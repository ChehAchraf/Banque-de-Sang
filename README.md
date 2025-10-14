# 🩸 Banque de Sang - Blood Bank Management System

A comprehensive web application for managing blood donations, donors, and recipients. Built with Java servlets, JSP, and PostgreSQL, this system helps connect blood donors with those in need of blood transfusions.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [System Architecture](#system-architecture)
- [Database Schema](#database-schema)
- [Installation & Setup](#installation--setup)
- [Deployment with WAR File](#deployment-with-war-file)
- [API Endpoints](#api-endpoints)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)

## 🎯 Overview

The Blood Bank Management System is designed to streamline the process of blood donation management. It provides a platform where:

- **Donors** can register and update their information
- **Recipients** can request blood and specify their urgency level
- **Administrators** can manage donations and match compatible donors with recipients
- **The system** automatically handles blood type compatibility and urgency prioritization

## ✨ Features

### Core Functionality
- **Donor Management**: Register, update, and manage donor profiles
- **Recipient Management**: Register patients needing blood with urgency levels
- **Blood Type Compatibility**: Automatic matching based on ABO and Rh factors
- **Urgency System**: Priority-based recipient management (Normal, Urgent, Critical)
- **Donation Tracking**: Record and track blood donations
- **Real-time Dashboard**: Statistics and overview of donors/recipients

### Advanced Features
- **Responsive Design**: Modern UI with Tailwind CSS
- **Mobile-friendly**: Optimized for mobile devices
- **Real-time Statistics**: Live dashboard with donor/recipient counts
- **Status Management**: Track donor availability and recipient status
- **Compatibility Checking**: Ensures safe blood type matching

## 🛠️ Technology Stack

### Backend
- **Java 17**: Core programming language
- **Jakarta Servlet API 6.1.0**: Web framework
- **JSP (JavaServer Pages)**: View layer with JSTL
- **Hibernate 7.0.4**: ORM for database operations
- **PostgreSQL 42.7.3**: Database management system

### Frontend
- **Tailwind CSS**: Utility-first CSS framework
- **Font Awesome**: Icons and visual elements
- **Google Fonts (Inter)**: Typography
- **JavaScript**: Client-side interactions

### Development Tools
- **Maven**: Build and dependency management
- **JUnit 5**: Unit testing framework
- **Mockito**: Mocking framework for tests
- **Tomcat 7**: Application server

## 🏗️ System Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │    Business     │    │      Data       │
│      Layer      │    │     Layer       │    │     Layer       │
├─────────────────┤    ├─────────────────┤    ├─────────────────┤
│ • JSP Pages     │◄──►│ • Servlets      │◄──►│ • PostgreSQL    │
│ • Tailwind CSS  │    │ • Services      │    │ • Hibernate     │
│ • JavaScript    │    │ • Validation    │    │ • Entities      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Layer Description
- **Presentation Layer**: JSP pages with modern UI components
- **Business Layer**: Servlet controllers and service classes
- **Data Layer**: Hibernate entities and DAO pattern implementation

## 🗄️ Database Schema

### Entity Relationships
```
Account (Abstract Base)
├── Donneur (Blood Donor)
│   └── Many-to-One → Receveur
└── Receveur (Blood Recipient)
    └── One-to-Many → Donneur

Donation
├── Many-to-One → Donneur
└── Many-to-One → Receveur
```

### Key Entities
- **Account**: Base class with common attributes (name, contact, blood type, etc.)
- **Donneur**: Blood donors with availability status
- **Receveur**: Blood recipients with urgency levels
- **Donation**: Records of blood donations between donors and recipients

### Enums
- **GroupeSanguin**: O+, O-, A+, A-, B+, B-, AB+, AB-
- **Urgence**: NORMAL (1 bag), URGENT (3 bags), CRITIQUE (4 bags)
- **EtatReceveur**: EN_ATTENTE, SATISFAIT
- **Disponibilite**: DISPONIBLE, NON_DISPONIBLE, NON_ELIGIBLE

## 🚀 Installation & Setup

### Prerequisites
- Java 17 or higher
- Maven 3.6+
- PostgreSQL 12+
- Tomcat 9+ or compatible servlet container

### Step 1: Database Setup
```sql
-- Create database
CREATE DATABASE banque_sang_db;

-- Create user (optional)
CREATE USER banque_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE banque_sang_db TO banque_user;
```

### Step 2: Configuration
Update `src/main/resources/META-INF/persistence.xml`:
```xml
<property name="jakarta.persistence.jdbc.url" 
          value="jdbc:postgresql://localhost:5432/banque_sang_db"/>
<property name="jakarta.persistence.jdbc.user" 
          value="postgres"/>
<property name="jakarta.persistence.jdbc.password" 
          value="your_password"/>
```

### Step 3: Build and Deploy
```bash
# Clone the repository
git clone https://github.com/ChehAchraf/Banque-de-Sang.git
cd Banque-de-Sang

# Build the project
mvn clean compile

# Package as WAR
mvn clean package

# Deploy to Tomcat
cp target/banque-de-sang-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/
```


```

## 📖 Usage Guide

### Accessing the Application
1. Navigate to `http://localhost:8080/banque-de-sang-1.0-SNAPSHOT/`
2. The homepage displays a dashboard with statistics and recent donors/recipients

### Adding a Donor
1. Click "Nouveau Donneur" or "Devenir Donneur"
2. Fill in the required information:
   - Personal details (name, phone, CIN)
   - Medical information (blood type, weight, diseases)
   - Availability status
3. Submit the form

### Adding a Recipient
1. Click "Nouveau Receveur" or "Demander du Sang"
2. Fill in the required information:
   - Personal details
   - Medical information
   - Urgency level (Normal/Urgent/Critical)
3. Submit the form

### Managing Donations
1. Click "Donation" or "Faire une Donation"
2. Select a recipient or donor
3. The system will show compatible matches
4. Select the appropriate donor-recipient pair
5. Confirm the donation

### Viewing Records
- **Donors**: Click "Voir Tout" in the donors section
- **Recipients**: Click "Voir Tout" in the recipients section
- **Details**: Click on any donor/recipient to view detailed information

## 📦 Deployment with WAR File

### Using the Pre-built WAR File

The project includes a pre-built WAR file: `banque-de-sang-1.0-SNAPSHOT.war`


#### Option 2: Manual Deployment
```bash
# Stop Tomcat
$TOMCAT_HOME/bin/shutdown.sh

# Copy WAR file to webapps directory
cp banque-de-sang-1.0-SNAPSHOT.war $TOMCAT_HOME/webapps/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh
```

#### Option 3: Using Maven Tomcat Plugin
```bash
# Deploy directly using Maven
mvn tomcat7:deploy

# Or redeploy if already deployed
mvn tomcat7:redeploy
```

### Post-Deployment Configuration
1. Ensure PostgreSQL is running
2. Verify database connection in the application
3. Access the application at: `http://localhost:8080/banque-de-sang-1.0-SNAPSHOT/`

### Troubleshooting WAR Deployment
- **Database Connection Issues**: Verify PostgreSQL is running and credentials are correct
- **Port Conflicts**: Ensure port 8080 is available or configure Tomcat to use a different port
- **Memory Issues**: Increase Tomcat heap size if needed: `-Xmx1024m`

## 🔗 API Endpoints

### Main Controllers
- **`/`**: Homepage with dashboard
- **`/donneur`**: Donor management
  - `GET /donneur?action=add`: Add donor form
  - `GET /donneur?action=list`: List all donors
  - `GET /donneur?action=view&id={id}`: View donor details
  - `POST /donneur`: Create/update donor
- **`/receveur`**: Recipient management
  - `GET /receveur?action=add`: Add recipient form
  - `GET /receveur`: List recipients (sorted by priority)
  - `POST /receveur`: Create/update recipient
- **`/donation`**: Donation management
  - `GET /donation?action=form`: Donation form
  - `POST /donation`: Process donation

### URL Patterns
```
/donneur          → DonneurServlet
/receveur         → ReceveurServlet
/add/receveur     → ReceveurServlet
/receveur/details → ReceveurDetailsServlet
/donation         → DonationServlet
/operation/*      → ReceveurServlet
/assets/*         → Static resources
```

## 📸 Screenshots

### Dashboard Overview

### Donor Registration
![Donor Form](screenshots/donneurform.png)
*Form for registering new blood donors*

### Recipient Management
![Recipient List](screenshots/recman.png)
*List of recipients sorted by priority and urgency*

### Donation Process
![Donation Form](screenshots/donationform.png)
*Interface for matching donors with recipients*

---
### Class diagram
![Donation Form](uml/blood-banque.jpeg)
*class diagram for the entire application*





### Code Style
- Follow Java naming conventions
- Use meaningful variable and method names
- Add Javadoc comments for public methods
- Ensure proper error handling

### Testing
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=DonneurDAOTest

# Generate test coverage report
mvn jacoco:report
```









---

*Made with ❤️ to help save lives through efficient blood donation management*
