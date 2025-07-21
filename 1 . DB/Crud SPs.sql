----- SPs -----

------------ p1 ---------------

----- Cargo_Details table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectCargo_Details
AS
BEGIN
    SELECT * FROM Cargo_Details
END
----- SP INSERT
GO
CREATE PROCEDURE InsertCargo_Details
    @Cargo_id varchar(50),
	@Description varchar(255)
AS
BEGIN
    INSERT INTO Cargo_Details(Cargo_ID, Description)
	VALUES(@Cargo_id, @Description)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateCargo
    @Cargo_id varchar(50),
	@Description varchar(255)
AS
BEGIN
    UPDATE Cargo_Details
	SET Description = @Description
	WHERE Cargo_id = @Cargo_id
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteTopic
    @Cargo_id varchar(50)
AS
BEGIN
    DELETE FROM Cargo_Details
	WHERE Cargo_id = @Cargo_id
END

--------------------------------------------------------------------
----- Dock table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectDock
AS
BEGIN
    SELECT * FROM Dock
END
----- SP INSERT
GO
CREATE PROCEDURE InsertDock
    @Dock_ID varchar(50),
	@Availabe bit
AS
BEGIN
    INSERT INTO Dock(Dock_ID, Available)
	VALUES(@Dock_ID, @Availabe)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateDock
    @Dock_ID varchar(50),
	@Available bit
AS
BEGIN
    UPDATE Dock
	SET Available = @Available
	WHERE Dock_ID = @Dock_ID
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteDock
    @Dock_ID varchar(50)
AS
BEGIN
    DELETE FROM Dock
	WHERE Dock_ID = @Dock_ID
END
--------------------------------------------------------------------------
----- Ship table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectShip
AS
BEGIN
    SELECT * FROM Ship
END
----- SP INSERT
GO
CREATE PROCEDURE InsertShip
    @IMO_Code varchar(20),
	@Ship_Name varchar(100),
	@Ship_Type varchar(50),
	@Falg varchar(50)
AS
BEGIN
    INSERT INTO Ship(IMO_Code, Ship_Name, Ship_Type, Flag)
	VALUES(@IMO_Code, @Ship_Name, @Ship_Type, @Falg)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateShip
    @IMO_Code varchar(20),
	@Ship_Name varchar(100),
	@Ship_Type varchar(50),
	@Falg varchar(50)
AS
BEGIN
    UPDATE Ship
	SET Ship_Name = @Ship_Name
	WHERE IMO_Code = @IMO_Code
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteShip
    @IMO_Code varchar(20)
AS
BEGIN
    DELETE FROM Ship
	WHERE IMO_Code = @IMO_Code
END
--------------------------------------------------------------------------
----- Ship_Docking table ----- Bridge table
----- SP SELECT
GO
CREATE PROCEDURE SelectShip_Dock
AS
BEGIN
    SELECT * FROM Ship_Docking
END

--------------------------------------------------------------------------

----- Ship_owner table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectShip_owner
AS
BEGIN
    SELECT * FROM Ship_Owner
END
----- SP INSERT
GO
CREATE PROCEDURE InsertShip_owner
    @Company_ID varchar(50),
	@Company_Name varchar(100)
AS
BEGIN
    INSERT INTO Ship_Owner(Company_ID, Company_Name)
	VALUES(@Company_ID, @Company_Name)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateShip_owner
    @Company_ID varchar(50),
	@Company_Name varchar(100)
AS
BEGIN
    UPDATE Ship_Owner
	SET Company_Name = @Company_Name
	WHERE Company_ID = @Company_ID
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteShip_owner
    @Company_ID varchar(50)
AS
BEGIN
    DELETE FROM Ship_Owner
	WHERE Company_ID = @Company_ID
END
--------------------------------------------------------------------------
----- Terminal table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectTerminal
AS
BEGIN
    SELECT * FROM Terminal
END
----- SP INSERT
GO
CREATE PROCEDURE InsertTerminal
    @Terminal_ID varchar(50),
	@Name varchar(100)
AS
BEGIN
    INSERT INTO Terminal(Terminal_ID, [Name])
	VALUES(@Terminal_ID, @Name)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateTerminal
    @Terminal_ID varchar(50),
	@Name varchar(100)
AS
BEGIN
    UPDATE Terminal
	SET Name = @Name
	WHERE Terminal_ID = @Terminal_ID
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteTerminal
    @Terminal_ID varchar(50)
AS
BEGIN
    DELETE FROM Terminal
	WHERE Terminal_ID = @Terminal_ID
END
--------------------------------------------------------------------------
----- Voyage table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectVoyage
AS
BEGIN
    SELECT * FROM Voyage
END
----- SP INSERT
GO
CREATE PROCEDURE InsertVoyage
    @Voyage_ID varchar(50),
	@Origin_Country_Port varchar(100),
	@Status varchar(30)
AS
BEGIN
    INSERT INTO Voyage(Voyage_ID, Origin_Country_Port, [Status]) 
	VALUES(@Voyage_ID, @Origin_Country_Port, @Status)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateVoyage
    @Voyage_ID varchar(50),
	@Origin_Country_Port varchar(100),
	@Status varchar(30)
AS
BEGIN
    UPDATE Voyage
	SET Origin_Country_Port = @Origin_Country_Port
	WHERE Voyage_ID = @Voyage_ID and [Status] = @Status
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteVoyage
    @Voyage_ID varchar(50),
	@Status varchar(30)
AS
BEGIN
    DELETE FROM Voyage
	WHERE Voyage_ID = @Voyage_ID and [Status] = @Status
END
--------------------------------------------------------------------------
----- Yard table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectYard
AS
BEGIN
    SELECT * FROM Yard
END
----- SP INSERT
GO
CREATE PROCEDURE InsertYard
    @Yard_ID varchar(50),
	@Yard_Type varchar(50)
AS
BEGIN
    INSERT INTO Yard(Yard_ID, Yard_Type)
	VALUES(@Yard_ID, @Yard_Type)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateYard
    @Yard_ID varchar(50),
	@Terminal_ID varchar(50),
 	@Yard_Type varchar(50)
AS
BEGIN
    UPDATE Yard
	SET Yard_Type = @Yard_Type
	WHERE Yard_ID = @Yard_ID and Terminal_ID =@Terminal_ID
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteYard
    @Yard_ID varchar(50),
	@Terminal_ID varchar(50)
AS
BEGIN
    DELETE FROM Yard
	where Yard_ID = @Yard_ID and Terminal_ID = @Terminal_ID
END


-------------------------------------------------------------------------------

------------ p2 --------------

----- Cargo_Operation table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectCargo_Operation
AS
BEGIN
    SELECT * FROM Cargo_Operation
END
----- SP INSERT
GO
CREATE PROCEDURE InsertCargo_Operation
    @cargo_operation_id varchar(50),
	@cargo_id varchar(50),
	@terminal_name varchar(50)
AS
BEGIN
    INSERT INTO Cargo_Operation(cargo_operation_id, cargo_id,terminal_name)
	VALUES(@cargo_operation_id,@cargo_id, @terminal_name)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateCargo_Operation
    @cargo_operation_id varchar(50),
	@cargo_id varchar(50),
	@terminal_name varchar(50)
AS
BEGIN
    UPDATE Cargo_Operation
	SET cargo_id = @cargo_id, terminal_name = @terminal_name
	WHERE cargo_operation_id = @cargo_operation_id
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteCargo_Operation
    @cargo_operation_id varchar(50)
AS
BEGIN
    DELETE FROM Cargo_Operation
	WHERE cargo_operation_id = @cargo_operation_id
END

--------------------------------------------------------------------
----- Cargo_Operation_charge table -----
----- SP SELECT
GO
CREATE PROCEDURE SelectCargo_Operation_charge
AS
BEGIN
    SELECT * FROM Cargo_Operation_charge
END
----- SP INSERT
GO
CREATE PROCEDURE InsertCargo_Operation_charge
    @operation_id varchar(50),
	@cargo_operation_id varchar(50),
	@operation_subtype varchar(50),
	@base_charge int
AS
BEGIN
    INSERT INTO Cargo_Operation_charge(operation_id, cargo_operation_id,operation_subtype, base_charge)
	VALUES(@operation_id,@cargo_operation_id, @operation_subtype, @base_charge)
END
----- SP UPDATE
GO
CREATE PROCEDURE UpdateCargo_Operation_charge
    @operation_id varchar(50),
	@cargo_operation_id varchar(50),
	@operation_subtype varchar(50),
	@base_charge int
AS
BEGIN
    UPDATE Cargo_Operation_charge
	SET operation_subtype = @operation_subtype, base_charge = @base_charge
	WHERE operation_id = @operation_id and cargo_operation_id = @cargo_operation_id
END
----- SP DELETE
GO
CREATE PROCEDURE DeleteCargo_Operation_charge
    @operation_id varchar(50), @cargo_operation_id varchar(50)
AS
BEGIN
    DELETE FROM Cargo_Operation_charge
	WHERE operation_id = @operation_id and cargo_operation_id = @cargo_operation_id
END


--------------------------------------------------------------------
----- cargo_violation_fees table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectcargo_violation_fees
AS
BEGIN
    SELECT * FROM cargo_violation_fees
END

----- SP INSERT
GO
CREATE PROCEDURE Insertcargo_violation_fees
    @violation_id varchar(50),
	@cargo_operation_id varchar(50),
	@violation_type varchar(50),
	@violation_fee int,
	@status int
AS
BEGIN
    INSERT INTO cargo_violation_fees
	VALUES(@violation_id,@cargo_operation_id, @violation_type, @violation_fee, @status)
END
----- SP UPDATE
GO
CREATE PROCEDURE Updatecargo_violation_fees
    @violation_id varchar(50),
	@cargo_operation_id varchar(50),
	@violation_type varchar(50),
	@violation_fee int
AS
BEGIN
    UPDATE cargo_violation_fees
	SET violation_type = @violation_type, violation_fee = @violation_fee
	WHERE violation_id = @violation_id and cargo_operation_id = @cargo_operation_id
END
----- SP DELETE
GO
CREATE PROCEDURE Deletecargo_violation_fees
    @violation_id varchar(50), @cargo_operation_id varchar(50)
AS
BEGIN
    DELETE FROM cargo_violation_fees
	WHERE violation_id = @violation_id and cargo_operation_id = @cargo_operation_id
END


--------------------------------------------------------------------
----- client_details table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectclient_details
AS
BEGIN
    SELECT * FROM client_details
END

----- SP INSERT
GO
CREATE PROCEDURE Insertclient_details
    @client_id varchar(50),
	@full_name varchar(50),
	@client_type varchar(50),
	@company_name varchar(50),
	@phone int,
	@email varchar(50),
	@address varchar(50),
	@number_of_containers int
AS
BEGIN
    INSERT INTO client_details
	VALUES(@client_id,@full_name, @client_type, @company_name, @phone, @email, @address, @number_of_containers)
END
----- SP UPDATE
GO
CREATE PROCEDURE Updateclient_details
    @client_id varchar(50),
	@client_type varchar(50),
	@company_name varchar(50),
	@number_of_containers int
AS
BEGIN
    UPDATE client_details
	SET client_type = @client_type, company_name = @company_name, number_of_containers = @number_of_containers
	WHERE client_id = @client_id 
END
----- SP DELETE
GO
CREATE PROCEDURE Deleteclient_details
    @client_id varchar(50)
AS
BEGIN
    DELETE FROM client_details
	WHERE client_id = @client_id  
END
--------------------------------------------------------------------
----- container_yard_entry table ----- bridge table
----- SP SELECT
GO
CREATE PROCEDURE Select_container_yard_entry
AS
BEGIN
    SELECT * FROM container_yard_entry
END
--------------------------------------------------------------------
----- containers_details table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectcontainers_details
AS
BEGIN
    SELECT * FROM containers_details
END

----- SP INSERT
GO
CREATE PROCEDURE Insertcontainers_details
    @container_id varchar(50),
	@volumne float,
	@weight int,
	@content varchar(50), 
	@status varchar(50)
AS
BEGIN
    INSERT INTO containers_details(container_id,volume, [weight], content, [status]) 
	VALUES(@container_id,@volumne, @weight, @content, @status)
END
----- SP UPDATE
GO
CREATE PROCEDURE Updatecontainers_details
    @container_id varchar(50),
	@volumne float,
	@weight int,
	@content varchar(50), 
	@status varchar(50)
AS
BEGIN
    UPDATE containers_details
	SET volume = @volumne,[weight] = @weight, content = @content, [status] = @status
	WHERE container_id = @container_id 
END
----- SP DELETE
GO
CREATE PROCEDURE Deletecontainers_details
    @container_id varchar(50)
AS
BEGIN
    DELETE FROM containers_details
	WHERE container_id = @container_id 
END
--------------------------------------------------------------------
----- employee_details table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectemployee_details
AS
BEGIN
    SELECT * FROM employee_details
END

----- SP INSERT
GO
CREATE PROCEDURE Insertemployee_details
    @emp_id varchar(50),
	@full_name varchar(50),
	@role varchar(50),
	@terminal_Name varchar(50)
AS
BEGIN
    INSERT INTO employee_details(emp_id,full_name , [Role], terminal_Name) 
	VALUES(@emp_id,@full_name , @role, @terminal_Name) 
END
----- SP UPDATE
GO
CREATE PROCEDURE Updateemployee_details
   @emp_id varchar(50),
   @role varchar(50)
AS
BEGIN
    UPDATE employee_details
	SET Role = @role
	WHERE emp_id = @emp_id 
END
----- SP DELETE
GO
CREATE PROCEDURE Deleteemployee_details
    @emp_id varchar(50)
AS
BEGIN
    DELETE FROM employee_details
	WHERE emp_id = @emp_id  
END
--------------------------------------------------------------------
----- customer_charge table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectcustomer_charge
AS
BEGIN
    SELECT * FROM customer_charge
END

----- SP INSERT
GO
CREATE PROCEDURE Insertcustomer_charge
    @invoice_id varchar(50),
	@client_id varchar(50),
	@container_id varchar(50),
	@customs_fees float,
	@date_documented datetime2(7),
	@payment_date datetime2(7),
	@payment_status tinyint
AS
BEGIN
    INSERT INTO customer_charge(invoice_id, container_id, customs_fees) 
	VALUES(@invoice_id,@client_id, @container_id , @customs_fees, @date_documented, @payment_date, @payment_status) 
END

--------------------------------------------------------------------
----- employee_operation table ----- bridge table
----- SP SELECT
GO
CREATE PROCEDURE Selectemployee_operation
AS
BEGIN
    SELECT * FROM employee_operation
END


--------------------------------------------------------------------
----- operation_subtype_catalog table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectoperation_subtype_catalog
AS
BEGIN
    SELECT * FROM operation_subtype_catalog
END

----- SP INSERT
GO
CREATE PROCEDURE Insertoperation_subtype_catalog
    @operation_id varchar(50),
	@operation_type varchar(50),
	@operation_subtype varchar(50),
	@base_charge int
AS
BEGIN
    INSERT INTO operation_subtype_catalog
	VALUES(@operation_id,@operation_type , @operation_subtype,@base_charge) 
END
----- SP UPDATE
GO
CREATE PROCEDURE Updateoperation_subtype_catalog
    @operation_id varchar(50),
	@base_charge int
AS
BEGIN
    UPDATE operation_subtype_catalog
	SET base_charge = @base_charge
	WHERE operation_id = @operation_id 
END
----- SP DELETE
GO
CREATE PROCEDURE Deleteoperation_subtype_catalog
    @operation_id varchar(50)
AS
BEGIN
    DELETE FROM operation_subtype_catalog
	WHERE operation_id = @operation_id 
END
--------------------------------------------------------------------
----- Ship_docking table ----- bridge table
----- SP SELECT
GO
CREATE PROCEDURE SelectShip_docking
AS
BEGIN
    SELECT * FROM Ship_docking
END

--------------------------------------------------------------------
----- violation_catalog table -----
----- SP SELECT
GO
CREATE PROCEDURE Selectviolation_catalog
AS
BEGIN
    SELECT * FROM violation_catalog
END

----- SP INSERT
GO
CREATE PROCEDURE Insertviolation_catalog
    @violation_id varchar(50),
	@violation_type varchar(50),
	@violation_description varchar(100),
	@violation_fee int,
	@liable_party varchar(50)
AS
BEGIN
    INSERT INTO violation_catalog
	VALUES(@violation_id,@violation_type , @violation_description,@violation_fee, @liable_party) 
END
----- SP UPDATE
GO
CREATE PROCEDURE Updateviolation_catalog
    @violation_id varchar(50),
	@violation_fee int
AS
BEGIN
    UPDATE violation_catalog
	SET violation_fee = @violation_fee
	WHERE violation_id = @violation_id 
END
----- SP DELETE
GO
CREATE PROCEDURE Deleteviolation_catalog
    @violation_id varchar(50)
AS
BEGIN
    DELETE FROM violation_catalog
	WHERE violation_id = @violation_id 
END
--------------------------------------------------------------------
----- shipping_company_charge table -----  fact table
----- SP SELECT
GO
CREATE PROCEDURE Selectshipping_company_charge
AS
BEGIN
    SELECT * FROM shipping_company_charge
END

----- SP INSERT
GO
CREATE PROCEDURE Insertshipping_company_charge
    @invoice_id varchar(50),
	@total_operation_charge float,
	@total_violation_fees float, 
	@documentation_date datetime2(7),
	@settlement_date datetime2(7), 
	@payment_status tinyint
AS
BEGIN
    INSERT INTO shipping_company_charge
	VALUES(@invoice_id,@total_operation_charge , @total_violation_fees,@documentation_date, @settlement_date, @payment_status) 
END