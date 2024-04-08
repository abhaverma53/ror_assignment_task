
# Ruby on rails project

Ruby version  3.2.0

Rails version 7.0.8.1

Database sqlite3


## Run Locally

Clone the project

```bash
git clone https://github.com/abhaverma53/ror_assignment_task
```

Go to the project directory

```bash
cd assignment_task
```

Install dependencies

```bash
bundle install
```

Start the server

```bash
rails s 

```

## Installation and sidekiq setup

Install Redis 

```bash
  sudo apt-get update
  sudo apt-get install redis-server
```
To start Redis 
 ```bash
  redis-server
```
To run sidekiq 
   ```bash
  bundle exec sidekiq
```
To import Excel sheet Product_data.xlsx
 ```bash
bundle exec rake import:products
```


## Environment Variables

To import the Excel file Product_data.xlsx, you will need to add the following environment variables to your .env file

`IMPORTED_EXCEL_FILE_PATH`



## Project Overview

* Models and Relationships
    
    Order

    * Associations: Belongs to a customer and a seller. Has and belongs to many products.
    * Fields: Includes the amount in decimal format.

    Customer

    * Associations: Has multiple orders and one user associated.
    * Fields: Contains the name and mobile number of the customer.

    Seller

    * Associations: Has multiple orders and one user associated.
    * Fields: Includes the name and mobile number of the seller.

    Product

    * Associations: Has and belongs to many orders.
    * Fields: Contains the name and amount in decimal format.

    PlatformApiCall

    * Associations: Belongs to a user.
    * Fields: Includes the requested URL, requested data, and response data.

    Orders_Products Table

    * Associations: Acts as a join table between orders and products.


Authentication and Authorization

    Basic Token Authentication

    * Utilized Devise and Simple Token Authentication gems for user authentication and token management.

    * Implemented endpoints for sign up, sign in, and logout using dedicated controllers (e.g., registration and session controllers).

    * Each user is assigned a unique authentication token upon successful sign-in, ensuring secure access to protected resources.

    CRUD Operations

    * Implemented CRUD operations for orders and products with before action callback and also added validation in product model to prevent the creation of products with duplicate name.

    Logging API Calls

    * Developed a reusable concern (mixin), ApiCallLogger, and integrated it into the product controller to capture request and response data, facilitating auditing and debugging.

Permission

    * Utilized the cancancan gem for managing user permissions across various models and actions. Integrated the gem by assigning roles to users, such as admin, customer, and seller, stored in the roles attribute of the users table. Defined different permissions for each role within the ability.rb file. Implemented the cancancan gem within the orders controller, utilizing callbacks as needed for permission handling.


Filters and Searches in Orders List API

    * Implemented filtering and searching functionality in the Orders List API using the ransack gem. Utilized custom query methods and ransack features to enable filtering and searching based on specific criteria, such as order amount. Employed includes for eager loading, allowing efficient retrieval of associated data. This approach enhances performance by minimizing database queries and optimizing data loading.


Sorting and Pagination

    * Implemented sorting and pagination features in the Products Controller using Active Record's order method and the Kaminari gem. Utilized the order method to sort products according to specific criteria. Integrated the Kaminari gem to enable pagination, limiting the number of products displayed per page. Additionally, configured the controller to accept page parameters, allowing users to retrieve products from specific pages. This setup enhances user experience by organizing and presenting product data in a structured and accessible manner.


Import Feature from Excel

    * Implemented a Rake task utilizing the Roo gem to import product data from an Excel file. Ensured that duplicate products are not created during the import process. Additionally, set up Sidekiq for handling background jobs, specifically for managing the import feature as a background task. Utilized Sidekiq's capabilities to efficiently process tasks asynchronously. Scheduled the import task to run daily at 2:30 PM using cron jobs facilitated by the Whenever gem. This setup automates the product import process, ensuring timely and efficient management of product data.