# E-Commerce Web Application - Test Automation Suite

Automated end-to-end test suite for the client's E-Commerce web application. This project covers critical business workflows including user authentication, product catalog management, shopping cart operations, and the complete checkout process using **Robot Framework** with **Python** and **SeleniumLibrary**.

![Robot Framework](https://img.shields.io/badge/Robot%20Framework-000000?style=flat&logo=robot-framework&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![Selenium](https://img.shields.io/badge/Selenium-43B02A?style=flat&logo=selenium&logoColor=white)

---

## Table of Contents

- [About the Project](#about-the-project)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Running Tests](#running-tests)
- [Test Coverage](#test-coverage)
- [Reports](#reports)
- [Author](#author)

---

## About the Project

This repository contains the automated test suite for the E-Commerce web application, covering critical business functionalities:

- **Authentication** - Login validation, error handling, account restrictions
- **Product Catalog** - Display verification, sorting, add-to-cart operations
- **Shopping Cart** - Item management, price verification, badge updates
- **Checkout** - End-to-end purchase flow, price/tax validation, form validation

The project follows a **keyword-driven** architecture with reusable keywords, page-object-style locator files, and centralized test data for maintainable and scalable test automation.

---

## Tech Stack

| Category | Technology |
|----------|------------|
| Language | Python 3.x |
| Framework | Robot Framework |
| Browser Automation | SeleniumLibrary |
| Browser | Chrome (Incognito) |
| Static Analysis | Robocop |
| Code Formatting | Robotidy |
| Reporting | Robot Framework HTML Reports |
| Version Control | Git |

---

## Project Structure

```
ECommerce_WebApp/
├── TestCases/                       # Test suite files (10 files, 35 test cases)
│   ├── TC_AUTH_001.robot            #   Authentication - Valid Login (3 TCs)
│   ├── TC_AUTH_002.robot            #   Authentication - Error Handling (4 TCs)
│   ├── TC_PRODUCT_001.robot         #   Product Catalog - Display (3 TCs)
│   ├── TC_PRODUCT_002.robot         #   Product Catalog - Sorting (4 TCs)
│   ├── TC_PRODUCT_003.robot         #   Product Catalog - Add to Cart (3 TCs)
│   ├── TC_CART_001.robot            #   Shopping Cart - Item Management (4 TCs)
│   ├── TC_CART_002.robot            #   Shopping Cart - Price Verification (3 TCs)
│   ├── TC_CHECKOUT_001.robot        #   Checkout - Complete Purchase Flow (3 TCs)
│   ├── TC_CHECKOUT_002.robot        #   Checkout - Price & Tax Validation (4 TCs)
│   └── TC_CHECKOUT_003.robot        #   Checkout - Form Validation (4 TCs)
├── resources/
│   ├── keywords/                    # Reusable keyword libraries
│   │   ├── common_keywords.resource
│   │   ├── login_keywords.resource
│   │   ├── inventory_keywords.resource
│   │   ├── cart_keywords.resource
│   │   └── checkout_keywords.resource
│   └── locators/                    # Page element locators
│       ├── login_locators.resource
│       ├── inventory_locators.resource
│       ├── cart_locators.resource
│       └── checkout_locators.resource
├── data/                            # Test data and configuration
│   └── test_data.resource
├── log/                             # Generated test reports
│   ├── log.html
│   ├── report.html
│   └── output.xml
├── requirements.txt
├── pyproject.toml
└── .robocop
```

---

## Getting Started

### Prerequisites

- Python 3.8 or higher
- pip (Python package manager)
- Chrome browser
- ChromeDriver
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   ```

2. **Navigate to project directory**
   ```bash
   cd ECommerce_WebApp
   ```

3. **Create virtual environment (recommended)**
   ```bash
   python -m venv venv

   # Windows
   venv\Scripts\activate

   # Mac/Linux
   source venv/bin/activate
   ```

4. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

---

## Running Tests

### Run all tests
```bash
robot --outputdir log TestCases/
```

### Run specific test suite
```bash
robot --outputdir log TestCases/TC_AUTH_001.robot
```

### Run tests by tag
```bash
# Run smoke tests only
robot --include smoke --outputdir log TestCases/

# Run regression tests
robot --include regression --outputdir log TestCases/

# Run authentication-related tests
robot --include authentication --outputdir log TestCases/

# Exclude work-in-progress tests
robot --exclude wip --outputdir log TestCases/
```

### Run specific test case by name
```bash
robot --test "TC_001: Login With Standard User Credentials" --outputdir log TestCases/
```

### Run with verbose output
```bash
robot --loglevel DEBUG --outputdir log TestCases/
```

---

## Test Coverage

### Authentication Tests (TC_AUTH_001, TC_AUTH_002)
| ID | Test Case | Type | Tag |
|----|-----------|------|-----|
| TC_001 | Login With Standard User Credentials | Positive | smoke |
| TC_002 | Verify Product Catalog Loads After Login | Positive | smoke |
| TC_003 | Verify Correct Number Of Products Displayed | Positive | regression |
| TC_004 | Verify Locked Account Cannot Access Application | Negative | regression |
| TC_005 | Verify Error On Invalid Password | Negative | regression |
| TC_006 | Verify Error When Username Is Empty | Negative | regression |
| TC_007 | Verify Error When Password Is Empty | Negative | regression |

### Product Catalog Tests (TC_PRODUCT_001 - TC_PRODUCT_003)
| ID | Test Case | Type | Tag |
|----|-----------|------|-----|
| TC_008 | Verify All Products Displayed On Catalog Page | Positive | smoke |
| TC_009 | Verify Product Count Matches Expected Total | Positive | smoke |
| TC_010 | Verify Each Product Has Complete Details | Positive | regression |
| TC_011 | Sort Products By Name A To Z | Functional | regression |
| TC_012 | Sort Products By Name Z To A | Functional | regression |
| TC_013 | Sort Products By Price Low To High | Functional | regression |
| TC_014 | Sort Products By Price High To Low | Functional | regression |
| TC_015 | Add Single Product To Cart From Catalog | Positive | smoke |
| TC_016 | Add Multiple Products To Cart | Positive | smoke |
| TC_017 | Add All Available Products To Cart | Positive | regression |

### Shopping Cart Tests (TC_CART_001, TC_CART_002)
| ID | Test Case | Type | Tag |
|----|-----------|------|-----|
| TC_018 | Navigate To Cart And Verify Products Present | Positive | smoke |
| TC_019 | Verify Product Quantities In Cart | Positive | regression |
| TC_020 | Remove Product From Cart | Functional | smoke |
| TC_021 | Return To Product Catalog From Cart | Navigation | regression |
| TC_022 | Verify Cart Prices Match Catalog Prices | Positive | smoke |
| TC_023 | Verify Cart Badge Reflects Item Count | Positive | regression |
| TC_024 | Verify Cart Item Count Matches Added Products | Positive | regression |

### Checkout Tests (TC_CHECKOUT_001 - TC_CHECKOUT_003)
| ID | Test Case | Type | Tag |
|----|-----------|------|-----|
| TC_025 | Complete Checkout With Valid Information | E2E | smoke |
| TC_026 | Verify Order Confirmation Message | Positive | smoke |
| TC_027 | Return To Product Catalog After Checkout | Navigation | regression |
| TC_028 | Verify Checkout Summary Subtotal | Positive | regression |
| TC_029 | Verify Tax Calculation Is Present | Positive | regression |
| TC_030 | Verify Total Equals Subtotal Plus Tax | Positive | regression |
| TC_031 | Verify Total Updates After Removing Product | Functional | regression |
| TC_032 | Checkout With Missing First Name | Negative | regression |
| TC_033 | Checkout With Missing Last Name | Negative | regression |
| TC_034 | Checkout With Missing Postal Code | Negative | regression |
| TC_035 | Cancel Checkout And Return To Cart | Navigation | regression |

**Total: 35 Test Cases** | Smoke: 12 | Regression: 23

---

## Reports

Robot Framework automatically generates HTML reports after each test run.

| File | Description |
|------|-------------|
| `report.html` | High-level test summary with pass/fail statistics |
| `log.html` | Detailed step-by-step execution log |
| `output.xml` | Machine-readable output for CI/CD integration |

### Open report after test run
```bash
# Windows
start log/report.html

# Mac
open log/report.html

# Linux
xdg-open log/report.html
```

---

## Author

**Mike Ryan Cervantes**
Senior QA Automation Engineer

- GitHub: [@noobcat0418](https://github.com/noobcat0418)
- LinkedIn: [Mikeryan Cervantes](https://www.linkedin.com/in/mikeryan-cervantes)
- Email: cervantesmikeryan24@gmail.com
