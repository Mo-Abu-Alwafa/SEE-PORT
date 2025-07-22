<!-- Header Logo -->
<p align="center">
  <img src="Logo Wide Taged.png" alt="SEE PORT Logo" width="600"/>
</p>

# SEEPORT - Marine Port Management Solution

---

## 🚢 Project Overview

**SEE PORT** is a comprehensive smart solution that helps marine ports run smoother and faster by bringing all cargo, ship, and yard operations into one unified system. With SEE PORT, port managers, operators, officers, and supervisors can track shipments and cargo, manage resources, and handle billing automatically—all in real-time—making daily work easier, reducing mistakes, and helping the port serve ships and clients better than ever before.

### 🎯 Problem Statement
Marine ports traditionally suffer from **scattered data** across multiple systems on operation role level or on different ports level too with no unified database, leading to:
- Inefficient operations management
- Data inconsistencies and errors
- Poor resource allocation
- Delayed decision-making
- Lack of real-time visibility

### 👥 Target Users
- **Port Operators**: Daily cargo and ship management
- **Port Officers**: Customs, security, and documentation
- **Port Managers**: Strategic decision-making and oversight
- **Port Supervisors**: Operational coordination and monitoring

---

## 📂 Git Repository Structure

The project is organized in a structured Git repository with clear separation of concerns:

### 🗂️ Repository Organization
- **`1. DB/`** - Database implementation and schema with ERD
- **`2. DWH/`** - Data Warehouse and ETL processes using SSIS
- **`3. SSRS/`** - SQL Server Reporting Services reports and dashboards
- **`4. Dashboards sample/`** - Power BI dashboards sample
- **`5. Web App/`** - web application overview

### 📋 Development Workflow
1. **Database First**: Schema design and implementation
2. **ETL Integration**: Data warehouse and transformation processes
3. **Reporting Layer**: SSRS reports for operational insights
4. **Analytics Layer**: Power BI dashboards for strategic analysis
5. **Application Layer**: Web application for end-user interaction

---

## 📋 Project Development Phases

This project follows a comprehensive development lifecycle covering database design, ETL processes, reporting, analytics, and web application development.

### 🏗️ Phase 1: Database Design & Schema

#### Entity Relationship Diagram (ERD)
- **Key Entities**:
  - Ships (IMO codes, specifications, company details)
  - Cargo (containers, types, locations)
  - Voyages (schedules, routes, status)
  - Operations (loading, unloading, customs,...)
  - Employees (roles, permissions, operations)
  - Yards (storage locations, capacity)
  - Docks (berthing, scheduling)

<!-- ERD Image -->
<p align="center">
  <img src="1 . DB/ERD SEE PORT Taged.png" alt="SEEPORT ERD" width="600"/>
</p>

#### Database Schema Implementation
- **Database System**: Microsoft SQL Server (MSSQL)
- **Features**:
  - Stored Procedures for complex business logic
  - Triggers for data integrity
  - Audting Tables for operators operation history
  
- **Schema Files**: Located in  `1. DB/` directory

<!-- Schema Image -->
<p align="center">
  <img src="1 . DB/Schema SEE PORT Taged.png" alt="SEEPORT Schema" width="600"/>
</p>


### 🔄 Phase 2: ETL & Data Integration

#### SQL Server Integration Services (SSIS)
- **Processes**:
  - Data extraction from source systems
  - Data validation
  - Transformation according to business rules
  - Loading into target database tables
- **SSIS Files**: Located in `2. DWH/` directory

<!-- DWH Schema Image -->
<p align="center">
  <img src="2 . DWH/DWH Schema.png" alt="SEEPORT Schema" width="600"/>
</p>

### 📊 Phase 3: Reporting & Analytics

#### SQL Server Reporting Services (SSRS)
- **Report Types**: Operational, managerial, and executive reports
- **Key Reports**:
  - Ship arrival/departure schedules
  - Cargo throughput analytics
  - Operational efficiency metrics
  - Financial performance summaries
  - Resource utilization reports
- **SSRS Files**: Located in `3. SSRS/` directory

<!-- SSRS Sample Image -->
<p align="center">
  <img src="3 . SSRS/1.Ships by Terminal.png" alt="SSRS Report Sample" width="600"/>
</p>

#### Power BI Dashboards
- **Analytics Platform**: Microsoft Power BI for advanced visualizations
- **Key Insights**:
  - Real-time port operations monitoring
  - Predictive analytics for capacity planning
  - Performance KPIs and trends
  - Resource allocation optimization
  - Revenue and cost analysis
- **Power BI Files**: Located in `4. Dashboards sample/` directory

<!-- Power BI Sample Image -->
<p align="center">
  <img src="4 . Dashboards sample\Operational .png" alt="Power BI Dashboard Sample" width="600"/>
</p>

### 🌐 Phase 4: Web Application Development

#### Technology Stack
- **Frontend**: React with TypeScript
- **Database**: MSSQL with stored procedures
- **Backend**: Node.js with Express

#### Application Features
- **Role-Based Access**: Different interfaces for operators, officers, managers
- **Real-Time Operations**: Live tracking of ships, cargo, and operations
- **Beta version**: Comprehensive demonstration with sample data

#### Key Modules
1. **Ships Management**: IMO code tracking, specifications, company details
2. **Voyages Management**: Schedule management, dock assignments, status tracking
3. **Operations Management**: operations, charges, billing
4. **Cargo Handling**: Container tracking, location management, status updates
5. **Security Operations**: Violation tracking, security protocols, incident management
6. **Customs Operations**: Documentation, clearance processes, compliance tracking
7. **Documentation**: Invoice generation, PDF exports, record billing

<!-- Web App Sample Image -->
<p align="center">
  <img src="5. Web App/LOGIN page.jpg" alt="Web App Sample" width="600"/>
</p>

#### [▶️▶️**Try Beta Version**◀️◀️](https://see-port-beta.vercel.app/)

---

## 👥 **SEE PORT** Team Members

- [Mohamed Abu Al-Wafa](https://github.com/Mo-Abu-Alwafa)
- [Hassan Sakkoury](https://github.com/hassansakkoury)
- [Zeinab Sharaf](https://github.com/zeina0110)
- [Ahmed Rabie](https://github.com/theNubian007)
- [Mohamed Ezzat](https://github.com/mohamedezzat)

---

## 📄 License

Licensed under the [Apache License 2.0](LICENSE).

---

## 📞 Contact & Support

- [**project repository**](https://github.com/Mo-Abu-Alwafa/SEE-PORT.git)
- [**Issues**](https://github.com/Mo-Abu-Alwafa/SEE-PORT/issues)

---

*SEE PORT - Transforming Marine Port Operations Through Smart Technology*
