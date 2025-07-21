
----- other sps for app and buisness management ----- 

-- 1. Returns dashboard summary metrics for ships, docks, containers, operations, violations, and revenue.

CREATE PROCEDURE sp_GetDashboardSummary
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        (SELECT COUNT(*) FROM Ship) AS TotalShips,
        (SELECT COUNT(*) FROM Dock WHERE Available = 1) AS AvailableDocks,
        (SELECT COUNT(*) FROM containers_details WHERE status = 'In Yard') AS ContainersInYard,
        (SELECT COUNT(*) FROM cargo_operation WHERE status = 1) AS ActiveOperations,
        (SELECT COUNT(*) FROM cargo_violation_fees WHERE status = 1) AS ViolationsToday,
        (SELECT ISNULL(SUM(base_charge), 0) FROM cargo_operation_charge WHERE status = 1) AS RevenueToday
END

------------------------------------------------------------

-- 2. Logs any significant user/system action for auditing and compliance.

CREATE TABLE AuditLog (
  AuditID INT IDENTITY PRIMARY KEY,
  EventType VARCHAR(50),
  EntityName VARCHAR(50),
  EntityID VARCHAR(50),
  OldValue NVARCHAR(MAX),
  NewValue NVARCHAR(MAX),
  PerformedBy VARCHAR(50),
  PerformedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE PROCEDURE sp_LogAuditEvent
    @EventType VARCHAR(50),
    @EntityName VARCHAR(50),
    @EntityID VARCHAR(50),
    @OldValue NVARCHAR(MAX),
    @NewValue NVARCHAR(MAX),
    @PerformedBy VARCHAR(50)
AS
BEGIN
    INSERT INTO AuditLog (EventType, EntityName, EntityID, OldValue, NewValue, PerformedBy)
    VALUES (@EventType, @EntityName, @EntityID, @OldValue, @NewValue, @PerformedBy)
END

------------------------------------------------------------

-- 3. Returns the full change history for a given entity for auditing and troubleshooting.

CREATE PROCEDURE sp_GetEntityChangeHistory
    @EntityName VARCHAR(50),
    @EntityID VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM AuditLog
    WHERE EntityName = @EntityName AND EntityID = @EntityID
    ORDER BY PerformedAt DESC
END

------------------------------------------------------------

-- 4. Records every login, logout, and failed login attempt for security monitoring.

CREATE TABLE UserAccessLog (
  LogID INT IDENTITY PRIMARY KEY,
  UserName VARCHAR(50),
  ActionType VARCHAR(20), -- 'login', 'logout', 'failed'
  IPAddress VARCHAR(50),
  DeviceInfo VARCHAR(255),
  AccessTime DATETIME DEFAULT GETDATE()
);
GO

CREATE PROCEDURE sp_LogUserAccess
    @UserName VARCHAR(50),
    @ActionType VARCHAR(20),
    @IPAddress VARCHAR(50),
    @DeviceInfo VARCHAR(255)
AS
BEGIN
    INSERT INTO UserAccessLog (UserName, ActionType, IPAddress, DeviceInfo)
    VALUES (@UserName, @ActionType, @IPAddress, @DeviceInfo)
END

------------------------------------------------------------

-- 5. Returns only the operations a user is allowed to see, based on their role and permissions.

CREATE PROCEDURE sp_GetUserPermittedOperations
    @EmpID VARCHAR(50)
AS
BEGIN
    SELECT co.*
    FROM cargo_operation co
    INNER JOIN employee_operation eo ON co.cargo_operation_id = eo.cargo_operation_id
    WHERE eo.emp_id = @EmpID
END

------------------------------------------------------------

-- 6. Calculates and returns the total charges for a given operation, including base and violation fees.

CREATE PROCEDURE sp_CalculateOperationCharges
    @CargoOperationID VARCHAR(50)
AS
BEGIN
    SELECT
        co.cargo_operation_id,
        SUM(coc.base_charge) AS TotalBaseCharge,
        ISNULL(SUM(cvf.violation_fee), 0) AS TotalViolationFees,
        SUM(coc.base_charge) + ISNULL(SUM(cvf.violation_fee), 0) AS TotalCharge
    FROM cargo_operation co
    LEFT JOIN cargo_operation_charge coc ON co.cargo_operation_id = coc.cargo_operation_id
    LEFT JOIN cargo_violation_fees cvf ON co.cargo_operation_id = cvf.cargo_operation_id
    WHERE co.cargo_operation_id = @CargoOperationID
    GROUP BY co.cargo_operation_id
END

------------------------------------------------------------

-- 7. Returns a chronological timeline of all actions/events for a specific operation.

CREATE PROCEDURE sp_GetOperationTimeline
    @CargoOperationID VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM AuditLog
    WHERE EntityName = 'cargo_operation' AND EntityID = @CargoOperationID
    ORDER BY PerformedAt ASC
END

------------------------------------------------------------

-- 8. Dock Availability Checker
-- Returns all docks that are currently available (Available = 1)

CREATE PROCEDURE sp_GetAvailableDocks
AS
BEGIN
    SELECT * FROM Dock WHERE Available = 1
END

------------------------------------------------------------

-- 9. Auto-Depart Voyages After 5 Days of ETD
-- Updates voyage status to 'departed' if 5 days have passed since ETD

CREATE PROCEDURE sp_AutoDepartVoyages
AS
BEGIN
    UPDATE Voyage
    SET status = 'departed'
    WHERE status <> 'departed'
      AND ETA_Egypt IS NOT NULL
      AND DATEDIFF(DAY, ETA_Egypt, GETDATE()) >= 5
END

------------------------------------------------------------

-- 10. All Ships Per Terminal, Aggregated by Month/Year
-- Returns count of ships per terminal, grouped by month and year

CREATE PROCEDURE sp_GetShipsPerTerminalByMonthYear
AS
BEGIN
    SELECT
        sd.Terminal_ID,
        YEAR(v.ETA_Egypt) AS [Year],
        MONTH(v.ETA_Egypt) AS [Month],
        COUNT(DISTINCT sd.IMO_Code) AS ShipCount
    FROM Ship_Docking sd
    INNER JOIN Voyage v ON sd.IMO_Code = v.IMO_Code
    WHERE v.ETA_Egypt IS NOT NULL
    GROUP BY sd.Terminal_ID, YEAR(v.ETA_Egypt), MONTH(v.ETA_Egypt)
END

------------------------------------------------------------

-- 11. All Ships in All Terminals, Aggregated by Month/Year
-- Returns count of all ships docked, grouped by month and year

CREATE PROCEDURE sp_GetAllShipsByMonthYear
AS
BEGIN
    SELECT
        YEAR(v.ETA_Egypt) AS [Year],
        MONTH(v.ETA_Egypt) AS [Month],
        COUNT(DISTINCT sd.IMO_Code) AS ShipCount
    FROM Ship_Docking sd
    INNER JOIN Voyage v ON sd.IMO_Code = v.IMO_Code
    WHERE v.ETA_Egypt IS NOT NULL
    GROUP BY YEAR(v.ETA_Egypt), MONTH(v.ETA_Egypt)
END
------------------------------------------------------------

-- 12. Total Charge Per Terminal, Aggregated by Month/Year
-- Returns total charge per terminal, grouped by month and year

CREATE PROCEDURE sp_GetTotalChargePerTerminalByMonthYear
AS
BEGIN
    SELECT
        sd.Terminal_ID,
        YEAR(co.operation_date) AS [Year],
        MONTH(co.operation_date) AS [Month],
        SUM(coc.base_charge) AS TotalCharge
    FROM Ship_Docking sd
    INNER JOIN cargo_operation co ON sd.IMO_Code = co.imo_code
    INNER JOIN cargo_operation_charge coc ON co.cargo_operation_id = coc.cargo_operation_id
    WHERE co.operation_date IS NOT NULL
    GROUP BY sd.Terminal_ID, YEAR(co.operation_date), MONTH(co.operation_date)
END

------------------------------------------------------------

-- 13. Total Charge All Terminals, Aggregated by Month/Year

CREATE PROCEDURE sp_GetTotalChargeAllTerminalsByMonthYear
AS
BEGIN
    SELECT
        YEAR(co.operation_date) AS [Year],
        MONTH(co.operation_date) AS [Month],
        SUM(coc.base_charge) AS TotalCharge
    FROM cargo_operation co
    INNER JOIN cargo_operation_charge coc ON co.cargo_operation_id = coc.cargo_operation_id
    WHERE co.operation_date IS NOT NULL
    GROUP BY YEAR(co.operation_date), MONTH(co.operation_date)
END

------------------------------------------------------------

-- 14. Number of Voyages Per Terminal, Aggregated by Month/Year

-- Returns number of voyages per terminal, grouped by month and year based on ETA_Egypt

CREATE PROCEDURE sp_GetVoyageCountPerTerminalByMonthYear
AS
BEGIN
    SELECT
        sd.Terminal_ID,
        YEAR(v.ETA_Egypt) AS [Year],
        MONTH(v.ETA_Egypt) AS [Month],
        COUNT(DISTINCT v.Voyage_ID) AS VoyageCount
    FROM Ship_Docking sd
    INNER JOIN Voyage v ON sd.IMO_Code = v.IMO_Code
    WHERE v.ETA_Egypt IS NOT NULL
    GROUP BY sd.Terminal_ID, YEAR(v.ETA_Egypt), MONTH(v.ETA_Egypt)
END

------------------------------------------------------------

-- 15. Number of Voyages All Terminals, Aggregated by Month/Year

CREATE PROCEDURE sp_GetVoyageCountAllTerminalsByMonthYear
AS
BEGIN
    SELECT
        YEAR(v.ETA_Egypt) AS [Year],
        MONTH(v.ETA_Egypt) AS [Month],
        COUNT(DISTINCT v.Voyage_ID) AS VoyageCount
    FROM Voyage v
    WHERE v.ETA_Egypt IS NOT NULL
    GROUP BY YEAR(v.ETA_Egypt), MONTH(v.ETA_Egypt)
END

------------------------------------------------------------

-- 16. Documentation Officer Insert Totals/Calculations
-- (This is typically handled by application logic, not a stored procedure, unless you want to log or validate the insert)
-- Example: Insert documentation totals for a voyage

CREATE TABLE DocumentationTotals (
    DocTotalID INT IDENTITY PRIMARY KEY,
    OfficerID VARCHAR(50),
    VoyageID VARCHAR(50),
    TotalAmount DECIMAL(18,2),
    InsertedAt DATETIME DEFAULT GETDATE()
);
GO

CREATE PROCEDURE sp_InsertDocumentationTotal
    @OfficerID VARCHAR(50),
    @VoyageID VARCHAR(50),
    @TotalAmount DECIMAL(18,2)
AS
BEGIN
    INSERT INTO DocumentationTotals (OfficerID, VoyageID, TotalAmount)
    VALUES (@OfficerID, @VoyageID, @TotalAmount)
END

------------------------------------------------------------

-- 17. Ship Draft vs Terminal Depth Checker
-- Returns ships that are not allowed to enter a terminal due to draft > terminal depth

CREATE PROCEDURE sp_GetShipsExceedingTerminalDepth
AS
BEGIN
    SELECT s.IMO_Code, s.Ship_Name, s.Draft, t.Terminal_ID, t.Depth
    FROM Ship s
    INNER JOIN Terminal t ON 1=1
    WHERE s.Draft > t.Depth
END

------------------------------------------------------------

-- 18. Available Yard Checker
-- Returns all yards that are currently available (Available = 1)

CREATE PROCEDURE sp_GetAvailableYards
AS
BEGIN
    SELECT * FROM [Yard details] WHERE Available = 1
END

------------------------------------------------------------

-- 19. Cargo Description Per Voyage
-- Returns all cargo descriptions for a given voyage

CREATE PROCEDURE sp_GetCargoDescriptionsByVoyage
    @VoyageID VARCHAR(50)
AS
BEGIN
    SELECT Description
    FROM Cargo_Details
    WHERE Voyage_ID = @VoyageID
END

------------------------------------------------------------

-- 20. Customs Calculation Total Per Client
-- Returns total customs fees per client

CREATE PROCEDURE sp_GetCustomsTotalPerClient
AS
BEGIN
    SELECT client_id, SUM(customs_fees) AS TotalCustomsFees
    FROM customer_charge
    GROUP BY client_id
END

------------------------------------------------------------

-- 21. Total Charge Per Company Owner (Ship)
-- Returns total charge per company owner (ship)

CREATE PROCEDURE sp_GetTotalChargePerCompanyOwner
AS
BEGIN
    SELECT s.Company_ID, SUM(coc.base_charge) AS TotalCharge
    FROM Ship s
    INNER JOIN cargo_operation co ON s.IMO_Code = co.imo_code
    INNER JOIN cargo_operation_charge coc ON co.cargo_operation_id = coc.cargo_operation_id
    GROUP BY s.Company_ID
END

------------------------------------------------------------

-- 22. Total Voyages Per Company Owner

CREATE PROCEDURE sp_GetTotalVoyagesPerCompanyOwner
AS
BEGIN
    SELECT s.Company_ID, COUNT(v.voyage_id) AS TotalVoyages
    FROM Ship s
    INNER JOIN Voyage v ON s.IMO_Code = v.IMO_Code
    GROUP BY s.Company_ID
END

------------------------------------------------------------

-- 23. Total Violations Per Company Owner

CREATE PROCEDURE sp_GetTotalViolationsPerCompanyOwner
AS
BEGIN
    SELECT s.Company_ID, COUNT(cvf.violation_id) AS TotalViolations
    FROM Ship s
    INNER JOIN cargo_operation co ON s.IMO_Code = co.imo_code
    INNER JOIN cargo_violation_fees cvf ON co.cargo_operation_id = cvf.cargo_operation_id
    GROUP BY s.Company_ID
END
------------------------------------------------------------

-- 24. Average Total Charge Per Year (All Terminals)

CREATE PROCEDURE sp_GetAverageTotalChargePerYear
AS
BEGIN
    SELECT
        YEAR(co.operation_date) AS [Year],
        AVG(coc.base_charge) AS AvgTotalCharge
    FROM cargo_operation co
    INNER JOIN cargo_operation_charge coc ON co.cargo_operation_id = coc.cargo_operation_id
    WHERE co.operation_date IS NOT NULL
    GROUP BY YEAR(co.operation_date)
END

------------------------------------------------------------

-- 25. Average Total Charge Per Month By Year For Each Terminal

CREATE PROCEDURE sp_GetAverageTotalChargePerMonthByYearPerTerminal
AS
BEGIN
    SELECT
        sd.Terminal_ID,
        YEAR(co.operation_date) AS [Year],
        MONTH(co.operation_date) AS [Month],
        AVG(coc.base_charge) AS AvgTotalCharge
    FROM Ship_Docking sd
    INNER JOIN cargo_operation co ON sd.IMO_Code = co.imo_code
    INNER JOIN cargo_operation_charge coc ON co.cargo_operation_id = coc.cargo_operation_id
    WHERE co.operation_date IS NOT NULL
    GROUP BY sd.Terminal_ID, YEAR(co.operation_date), MONTH(co.operation_date)
END


EXEC sp_GetAverageTotalChargePerMonthByYearPerTerminal;

------------------------------------------------------------

-- 26. sp_GetEmployeeActivityLog
-- Returns a summary of actions performed by a specific employee (from the audit log)

CREATE PROCEDURE sp_GetEmployeeActivityLog
    @EmpID VARCHAR(50)
AS
BEGIN
    SELECT
        AuditID,
        EventType,
        EntityName,
        EntityID,
        OldValue,
        NewValue,
        PerformedBy,
        PerformedAt
    FROM AuditLog
    WHERE PerformedBy = @EmpID
    ORDER BY PerformedAt DESC
END

------------------------------------------------------------

-- 27. sp_GetTerminalUtilizationStats
-- Returns utilization rates (capacity vs. actual) for terminals over time (monthly)

CREATE PROCEDURE sp_GetTerminalUtilizationStats
AS
BEGIN
    SELECT
        t.Terminal_ID,
        t.Name AS TerminalName,
        YEAR(v.ETA_Egypt) AS [Year],
        MONTH(v.ETA_Egypt) AS [Month],
        COUNT(DISTINCT sd.IMO_Code) AS ShipsDocked,
        t.Capacity,
        CAST(COUNT(DISTINCT sd.IMO_Code) AS FLOAT) / NULLIF(t.Capacity, 0) AS UtilizationRate
    FROM Terminal t
    LEFT JOIN Ship_Docking sd ON t.Terminal_ID = sd.Terminal_ID
    LEFT JOIN Voyage v ON sd.IMO_Code = v.IMO_Code
    WHERE v.ETA_Egypt IS NOT NULL
    GROUP BY t.Terminal_ID, t.Name, t.Capacity, YEAR(v.ETA_Egypt), MONTH(v.ETA_Egypt)
END

------------------------------------------------------------

-- 28. sp_GetContainerMovementHistory
-- Returns the full movement history of a container (yard entries/exits/turnaround)

CREATE PROCEDURE sp_GetContainerMovementHistory
    @ContainerID VARCHAR(50)
AS
BEGIN
    SELECT
        cye.container_id,
        cye.Terminal_id,
        cye.yard_id,
        cye.entry_date,
        cye.exit_date
    FROM container_yard_entry cye
    WHERE cye.container_id = @ContainerID
    ORDER BY cye.entry_date
END

------------------------------------------------------------

-- 29. sp_GetPendingPaymentsOrSettlements
-- Returns a list of unpaid or overdue charges for clients or shipping companies

CREATE PROCEDURE sp_GetPendingPaymentsOrSettlements
AS
BEGIN
    -- For clients (customer_charge)
    SELECT
        'Client' AS ChargeType,
        cc.invoice_id,
        cc.client_id,
        cc.container_id,
        cc.customs_fees,
        cc.date_documented,
        cc.payment_date,
        cc.payment_status
    FROM customer_charge cc
    WHERE cc.payment_status = 0 OR (cc.payment_date < GETDATE() AND cc.payment_status <> 1)

    UNION ALL

    -- For shipping companies (shipping_company_charge)
    SELECT
        'ShippingCompany' AS ChargeType,
        scc.invoice_id,
        NULL AS client_id,
        NULL AS container_id,
        scc.total_operation_charge AS customs_fees,
        scc.documentation_date AS date_documented,
        scc.settlement_date AS payment_date,
        scc.payment_status
    FROM shipping_company_charge scc
    WHERE scc.payment_status = 0 OR (scc.settlement_date < GETDATE() AND scc.payment_status <> 1)
END
------------------------------------------------------------

