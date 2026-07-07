# AlphaBlog 🚀

AlphaBlog is a modern, high-performance web publishing platform built with **Ruby on Rails 8.1** and **Bootstrap 5**. This repository demonstrates production-ready architectural decisions, robust relational database designs, security practices, and key performance optimizations.

---

## 💡 Key Architectural Highlights & Interviewer Talking Points

When reviewing this codebase, please take note of the following engineering decisions designed for scalability, security, and performance:

### 1. Advanced Database Modeling (Many-to-Many Association)
*   **Schema Design**: Implemented a robust many-to-many relationship between `Articles` and `Categories` using a join table (`articles_categories`).
*   **ActiveRecord Conventions**: The join model `ArticlesCategory` maps cleanly to the `articles_categories` table using Rails singularization and camelization conventions.
*   **Cascading Deletes**: Configured dependency chains so that deleting users automatically removes their associated articles, preserving database integrity.

### 2. High-Performance Optimization (Eager Loading / N+1 Prevention)
*   **The Problem**: Listing articles with their associated categories and authors initially suffered from the N+1 queries problem ($1 + 2N$ database queries, where $N$ is the number of articles on a page).
*   **The Solution**: Implemented eager loading in `ArticlesController` and `CategoriesController` using `.includes(:user, :categories)`. This optimized page load times by consolidating database requests into **exactly 3 queries**, regardless of page size.
*   **High-Speed Pagination**: Integrated the **Pagy** gem rather than bulkier alternatives to minimize memory footprint and keep request cycles extremely fast.

### 3. Bulletproof Security & Authorization
*   **Password Hashing**: Utilized `has_secure_password` via **bcrypt** to securely hash and salt user passwords before database entry.
*   **Privilege Control**: Restructured MVC filters using `before_action` constraints in controllers.
    *   Unauthenticated users can only read content.
    *   Registered users can only edit or delete their *own* articles.
    *   Only **Admin** users can create, edit, or update category mappings, protecting against privilege escalation.

### 4. DRY (Don't Repeat Yourself) View Patterns
*   **Polymorphic Form Partials**: Extracted common fields into reusable form partials (`_form.html.erb`).
*   **Dynamic Actions**: Leveraged ActiveModel helper methods (`@category.new_record?`) inside templates to dynamically adapt submit buttons, page titles, and cancel routes depending on whether the record is being created or edited.

---

## 🛠 Tech Stack & Tools

*   **Backend**: Ruby 4.0.5 + PRISM parser, Rails 8.1.3
*   **Database**: SQLite (Development) / PostgreSQL-ready
*   **Frontend**: Bootstrap 5 + Vanilla CSS custom animations (`animate-fade-in`, custom cards, and hover-lifts)
*   **Testing**: Minitest (Rails native test framework)

---

## 🚀 Local Setup Guide

Follow these steps to spin up the application on your local machine:

### 1. Prerequisites
Ensure you have **Ruby 4.0.5** and **SQLite** installed.

### 2. Installation
Clone the repository and install all dependencies:
```bash
git clone https://github.com/da5ater/alpha_blog.git
cd alpha_blog
bundle install
```

### 3. Database Setup
Create, migrate, and seed the database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

### 4. Run the Test Suite
Ensure the codebase is healthy by running the automated Minitest suite:
```bash
rails test
```

### 5. Start the Dev Server
Fire up the local Puma server:
```bash
rails server
```
Once booted, visit `http://localhost:3000` in your web browser.
