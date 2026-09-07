# Finora — Cross-Platform Personal Finance Manager

## 1. Product Overview

**Working App Name:** Finora  
**Tagline:** Know your money. Own your future.

Finora is a modern, feature-rich personal finance management application for individuals. It should go beyond a basic expense tracker and provide users with a complete view of their financial life.

### Target Platforms

- Android
- iOS
- Windows

### Development Environment

- VS Code
- Flutter
- Dart
- GitHub Copilot

---

# 2. Core Technology Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter |
| Language | Dart |
| IDE | VS Code |
| AI Coding Assistant | GitHub Copilot |
| Backend | Supabase |
| Database | PostgreSQL |
| Authentication | Supabase Auth |
| Local Database | SQLite / Drift |
| State Management | Riverpod |
| Navigation | go_router |
| Charts | fl_chart |
| Secure Storage | flutter_secure_storage |
| Version Control | Git + GitHub |

### Architecture Goal

Use a maintainable, scalable architecture rather than generating the entire application as one large AI-generated codebase.

Recommended high-level architecture:

```text
Flutter UI
    ↓
State Management
    ↓
Repositories
    ↓
Local Database / Sync Layer
    ↓
Supabase API
    ↓
PostgreSQL
```

The application should be designed as **offline-first** wherever practical.

---

# 3. Product Vision

Finora should allow a user to:

- Track income
- Track expenses
- Manage multiple financial accounts
- Record transfers
- Create budgets
- Manage bills
- Track subscriptions
- Manage loans and debts
- Create savings goals
- Monitor net worth
- Analyze cash flow
- Understand spending patterns
- Generate reports
- Search transactions
- Export financial data
- Receive reminders and alerts
- Use the application offline
- Synchronize data securely across devices

Future versions may include AI-powered financial insights and natural-language financial queries.

---

# 4. Authentication

Authentication should initially support:

- Email + password registration
- Email + password login
- Forgot password
- Password reset
- Email verification
- Logout
- Session persistence

Future authentication options may include:

- Google Sign-In
- Apple Sign-In
- Two-factor authentication
- Biometric app unlock

Do not store banking passwords, UPI PINs, card CVVs, or other sensitive banking credentials.

---

# 5. Required Screens

## Authentication

1. Splash Screen
2. Welcome Screen
3. Create Account
4. Login
5. Forgot Password
6. Reset Password
7. Email Verification

## Onboarding

8. Personal Setup
9. Currency Selection
10. Financial Tracking Preferences
11. Create First Account

## Main Application

12. Dashboard
13. Transactions
14. Add Transaction
15. Edit Transaction
16. Transaction Details
17. Search Transactions

## Accounts

18. Accounts
19. Add Account
20. Edit Account
21. Account Details
22. Account Transaction History

## Categories

23. Categories
24. Add Category
25. Edit Category

## Budgets

26. Budgets
27. Create Budget
28. Edit Budget
29. Budget Details

## Bills

30. Bills
31. Add Bill
32. Edit Bill
33. Bill Details

## Subscriptions

34. Subscriptions
35. Add Subscription
36. Edit Subscription
37. Subscription Details

## Recurring Transactions

38. Recurring Transactions
39. Add Recurring Transaction
40. Edit Recurring Transaction

## Debt Management

41. Debts
42. Add Debt
43. Edit Debt
44. Debt Details
45. Debt Payment History
46. Debt Payoff Simulator

## Savings

47. Savings Goals
48. Create Goal
49. Edit Goal
50. Goal Details
51. Add Goal Contribution

## Analytics

52. Analytics Dashboard
53. Spending Analysis
54. Income Analysis
55. Cash Flow
56. Net Worth
57. Financial Health

## Calendar

58. Financial Calendar
59. Daily Financial Summary

## Reports

60. Reports Dashboard
61. Monthly Report
62. Income Report
63. Expense Report
64. Category Report
65. Account Report
66. Net Worth Report
67. Cash Flow Report

## Settings

68. Settings
69. Profile
70. Currency & Regional Settings
71. Appearance
72. Notifications
73. Security
74. Data Management
75. Export Data
76. Import Data
77. Backup & Restore
78. About
79. Privacy
80. Terms
81. Delete Account

---

# 6. Main Navigation

Use a clean five-item bottom navigation on mobile:

```text
┌────────────────────────────────────────────┐
│                                            │
│                APP CONTENT                 │
│                                            │
├────────────────────────────────────────────┤
│ Home │ Transactions │ + │ Analytics │ More │
└────────────────────────────────────────────┘
```

The central `+` action should open:

- Expense
- Income
- Transfer

The **More** section should provide access to:

- Accounts
- Budgets
- Bills
- Subscriptions
- Recurring Transactions
- Debts
- Savings Goals
- Calendar
- Reports
- Categories
- Settings

For Windows, adapt the navigation to a responsive sidebar/navigation rail where appropriate.

---

# 7. Dashboard Requirements

The Dashboard should provide a quick overview of the user's financial situation.

### Required information

- Current total balance
- Net worth
- Current month income
- Current month expenses
- Savings
- Savings rate
- Recent transactions
- Spending by category
- Upcoming bills
- Upcoming subscriptions
- Budget status
- Financial alerts
- Quick Add Transaction

Example layout:

```text
Good evening

September 2026

NET WORTH
₹2,84,650
↑ ₹12,450 this month

Income              Expenses
₹52,000             ₹31,450

Cash Flow
Income      ₹52,000
Expenses    ₹31,450
Savings     ₹20,550

Spending
Food          ₹6,200
Shopping      ₹4,800
Transport     ₹3,100
Bills         ₹8,450

Upcoming
Electricity   ₹1,850
Netflix       ₹649
EMI           ₹8,500
```

---

# 8. Transaction System

Transactions are the core financial entity.

Transaction types:

- Expense
- Income
- Transfer

Required transaction fields:

```text
id
user_id
account_id
category_id
amount
type
description
transaction_date
created_at
updated_at
notes
```

Future fields may include:

- Merchant
- Tags
- Location
- Receipt
- Attachment
- Recurring transaction ID
- Split transaction information

### Transaction features

- Create
- Read
- Edit
- Delete
- Duplicate
- Search
- Filter
- Sort
- Split transactions
- Attach receipt
- Add tags
- Mark recurring
- Transfer between accounts

---

# 9. Account System

Account types:

- Cash
- Bank Account
- Credit Card
- Digital Wallet
- Loan
- Investment
- Other

Example:

```text
TOTAL BALANCE
₹2,84,650

BANK ACCOUNTS

SBI Savings
₹85,400

HDFC Savings
₹42,300

CASH

Wallet
₹4,500

CREDIT

HDFC Credit Card
-₹12,450
```

Account fields:

```text
id
user_id
name
type
currency
opening_balance
current_balance
institution_name
is_active
created_at
updated_at
```

---

# 10. Budget System

Budget types:

- Monthly
- Weekly
- Custom period

Budget features:

- Category budget
- Spending progress
- Remaining budget
- Overspending detection
- Budget alerts
- Roll-over budgets
- Budget history

Example:

```text
Food
₹6,200 / ₹8,000
77%

Shopping
₹4,800 / ₹5,000
96%

Transport
₹3,100 / ₹4,000
78%
```

---

# 11. Bills

Bill features:

- Bill name
- Amount
- Due date
- Category
- Account
- Recurrence
- Reminder
- Paid/unpaid status

Examples:

- Electricity
- Internet
- Rent
- EMI
- Insurance
- School fees

---

# 12. Subscription Manager

Track recurring subscriptions.

Example:

```text
Netflix        ₹649
Spotify        ₹119
Google One     ₹130
Adobe          ₹675

TOTAL
₹1,573/month

ANNUAL COST
₹18,876/year
```

Features:

- Subscription renewal date
- Monthly/annual cost
- Category
- Payment account
- Reminder
- Active/cancelled status
- Annual cost calculation

---

# 13. Debt Management

Track:

- Principal
- Outstanding balance
- Interest rate
- EMI/payment
- Due date
- Start date
- End date
- Payment history

Include a future **Debt Payoff Simulator** supporting:

- Debt Avalanche
- Debt Snowball
- Interest savings comparison
- Estimated payoff date

---

# 14. Savings Goals

Goal fields:

```text
id
user_id
name
target_amount
current_amount
target_date
linked_account
created_at
updated_at
```

Example:

```text
Emergency Fund

₹65,000 / ₹1,00,000

65%

₹35,000 remaining
Target: December 2026
```

---

# 15. Analytics

Analytics should provide:

### Spending

- Spending by category
- Spending by merchant
- Spending by account
- Spending by tag
- Daily/weekly/monthly trends

### Income

- Income by source
- Monthly income trend

### Cash Flow

- Income vs expense
- Net cash flow
- Savings rate

### Net Worth

Track:

```text
Assets - Liabilities = Net Worth
```

### Financial Health

Future score can consider:

- Savings rate
- Emergency fund
- Debt-to-income
- Budget adherence
- Spending volatility
- Recurring commitments

Do not present financial-health scores as professional financial advice.

---

# 16. Financial Calendar

Calendar should show:

- Bills
- Income
- Expenses
- Recurring transactions
- Subscription renewals
- Debt payments
- Budget events

Users should be able to tap a date and see its financial activity.

---

# 17. Reports

Reports should support:

- Monthly report
- Income report
- Expense report
- Category report
- Account report
- Cash-flow report
- Net-worth report

Export formats:

- CSV
- PDF
- Excel-compatible format

---

# 18. Search

Global transaction search should support:

- Merchant
- Description
- Category
- Account
- Amount
- Date
- Tags

Future AI search examples:

```text
Show my food expenses last month

Show transactions above ₹5,000

How much did I spend on Amazon this year?

What were my biggest expenses in August?
```

---

# 19. Notifications

Notification categories:

- Bill due
- Subscription renewal
- Budget threshold
- Overspending
- Goal progress
- Recurring transaction
- Weekly financial summary
- Monthly financial summary

Users must be able to control notification preferences.

---

# 20. Offline-First Requirements

Financial transactions should work without an Internet connection.

Recommended flow:

```text
User
 ↓
Flutter UI
 ↓
Repository
 ↓
Local SQLite Database
 ↓
Sync Engine
 ↓
Supabase
 ↓
PostgreSQL
```

When offline:

1. Save transaction locally.
2. Mark it as pending synchronization.
3. Continue allowing normal app usage.
4. Sync when connectivity returns.
5. Resolve conflicts safely.

Never silently lose user financial data.

---

# 21. Database Design

Initial PostgreSQL tables:

```text
profiles

accounts
account_types

transactions
transaction_categories
transaction_tags
transaction_tag_links

budgets
budget_categories

recurring_transactions

bills
subscriptions

debts
debt_payments

savings_goals
goal_contributions

attachments

notifications
user_settings
```

All user-owned financial tables must contain a `user_id` or have a secure ownership relationship.

### Security

Use Supabase Row Level Security (RLS).

Every user must only be able to:

- Read their own records
- Insert their own records
- Update their own records
- Delete their own records

Never disable RLS merely to make a feature work.

---

# 22. Recommended Project Structure

```text
finora/
│
├── android/
├── ios/
├── windows/
│
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
│
├── lib/
│   ├── main.dart
│   │
│   ├── core/
│   │   ├── theme/
│   │   ├── constants/
│   │   ├── router/
│   │   ├── utils/
│   │   └── errors/
│   │
│   ├── models/
│   │
│   ├── services/
│   │   ├── auth/
│   │   ├── database/
│   │   ├── sync/
│   │   └── notifications/
│   │
│   ├── repositories/
│   │
│   ├── features/
│   │   ├── auth/
│   │   ├── dashboard/
│   │   ├── transactions/
│   │   ├── accounts/
│   │   ├── budgets/
│   │   ├── bills/
│   │   ├── subscriptions/
│   │   ├── recurring/
│   │   ├── debts/
│   │   ├── goals/
│   │   ├── analytics/
│   │   ├── calendar/
│   │   ├── reports/
│   │   ├── categories/
│   │   └── settings/
│   │
│   └── widgets/
│
├── test/
├── pubspec.yaml
└── README.md
```

---

# 23. UI/UX Design Requirements

Design philosophy:

**Modern + Simple + Premium + Data-Rich**

Use:

- Clean layouts
- Strong visual hierarchy
- Large readable numbers
- Rounded cards
- Subtle borders
- Minimal visual clutter
- Consistent spacing
- Responsive layouts
- Excellent dark mode
- Smooth but restrained animations

Do not make every screen look like a dashboard.

The transaction entry experience should be extremely fast.

### Typography

Prefer:

- Inter
- Or another highly legible modern sans-serif

### Color semantics

Use a centralized theme:

- Positive = income/progress
- Negative = expenses/debt
- Warning = approaching limits/due dates
- Neutral = standard information

Do not hard-code colors throughout individual widgets.

---

# 24. Responsive Design

The same Flutter application must adapt to:

### Mobile

Use:

- Bottom navigation
- Full-screen pages
- Bottom sheets
- Touch-friendly controls

### Windows

Use:

- Navigation rail/sidebar
- Wider dashboard layouts
- Multi-column views where useful
- Keyboard and mouse interaction
- Resizable windows
- Tooltips

Never assume a fixed mobile screen width.

Use Flutter's responsive layout mechanisms.

---

# 25. AI Features — Future Roadmap

Do not implement AI features before the core financial engine is stable.

Potential AI features:

### AI Financial Assistant

Example:

> Where did I spend the most money last month?

Response:

> Food was your largest discretionary expense at ₹8,420, which was 18% higher than August.

### Automatic Categorization

Input:

```text
Swiggy ₹680
```

Suggested:

```text
Food → Food Delivery
```

### Financial Insights

Examples:

- Spending increased compared with previous month.
- Subscription costs increased.
- Savings rate changed.
- Unusual transaction detected.
- Budget is likely to be exceeded.

AI must explain calculations and should not invent financial data.

---

# 26. Security Rules

Because this application handles personal financial information:

1. Use HTTPS.
2. Use Supabase authentication.
3. Use Row Level Security.
4. Never expose service-role keys in the Flutter application.
5. Store sensitive local credentials securely.
6. Validate all user input.
7. Do not store bank passwords.
8. Do not store UPI PINs.
9. Do not store card CVVs.
10. Do not log sensitive financial information unnecessarily.
11. Implement account deletion correctly.
12. Provide data export.
13. Provide privacy controls.
14. Handle session expiration safely.

---

# 27. Development Strategy

Do NOT ask GitHub Copilot to generate the entire application in one request.

Build incrementally.

## Phase 1 — Foundation

- Create Flutter project
- Configure platforms
- Add dependencies
- Create architecture
- Configure theme
- Configure routing
- Connect Supabase
- Create authentication
- Create user profile

## Phase 2 — Core Finance

- Accounts
- Categories
- Transactions
- Add/edit/delete
- Transfers

## Phase 3 — Dashboard

- Balance
- Income
- Expenses
- Cash flow
- Recent transactions

## Phase 4 — Financial Management

- Budgets
- Bills
- Recurring transactions
- Subscriptions
- Goals
- Debts

## Phase 5 — Analytics

- Charts
- Spending analysis
- Income analysis
- Net worth
- Financial health

## Phase 6 — Offline

- SQLite
- Sync
- Conflict handling
- Connectivity detection

## Phase 7 — Advanced Features

- Search
- Reports
- Export
- Notifications
- App lock
- Biometrics

## Phase 8 — AI

- AI assistant
- Automatic categorization
- Financial insights
- Natural-language search

## Phase 9 — Production

- Testing
- Security review
- Performance optimization
- Accessibility
- Android release
- Windows release
- iOS release

---

# 28. GitHub Copilot Rules

When using GitHub Copilot:

### Rule 1
Do not modify unrelated files.

### Rule 2
Before creating a new service/model/widget, inspect the existing project structure.

### Rule 3
Reuse existing components.

### Rule 4
Do not duplicate business logic.

### Rule 5
Keep database operations inside repositories/services.

### Rule 6
Do not put Supabase queries directly inside UI widgets.

### Rule 7
Use strongly typed Dart models.

### Rule 8
Handle loading, success, empty, and error states.

### Rule 9
Do not hard-code user data.

### Rule 10
Write testable code.

### Rule 11
Do not remove security policies just to solve errors.

### Rule 12
After implementing a feature, run:

```bash
flutter analyze
flutter test
```

and fix issues before moving to the next feature.

---

# 29. Copilot Prompting Strategy

Use small implementation prompts.

Example:

```text
Read the current Finora project structure.

Implement only the email/password authentication module.

Requirements:
- Supabase Auth
- Register
- Login
- Logout
- Forgot password
- Session persistence
- Email verification handling

Follow the existing architecture.
Do not modify unrelated files.
Do not create duplicate services.
Keep Supabase calls outside UI widgets.
Handle loading, success and error states.
Use Riverpod for state management.

After implementation:
1. Run flutter analyze.
2. Fix all analyzer errors.
3. Explain which files were created or modified.
4. Do not implement any feature beyond authentication.
```

This is the style we should use throughout development.

---

# 30. Quality Standards

Every feature should satisfy:

### Functionality

- Works correctly
- Handles edge cases
- Handles errors
- Works offline where applicable

### UI

- Responsive
- Accessible
- Consistent
- Dark mode compatible

### Code

- Modular
- Strongly typed
- Reusable
- Testable
- No unnecessary duplication

### Security

- User data isolated
- No secret keys in client
- RLS enforced
- Sensitive data handled safely

### Performance

- Avoid unnecessary rebuilds
- Paginate large transaction lists
- Use database indexes
- Avoid loading entire transaction history unnecessarily

---

# 31. Important Product Principle

Finora should not simply answer:

> "How much did I spend?"

It should help answer:

> "Where is my money going?"

> "What can I improve?"

> "What bills are coming?"

> "How much can I safely spend?"

> "Am I progressing toward my goals?"

> "How is my financial position changing?"

The product should therefore combine:

**Tracking + Planning + Analysis + Awareness**

while avoiding unqualified financial advice.

---

# 32. Name and Branding

Current working name:

## Finora

Tagline:

**Know your money. Own your future.**

Before public release, verify:

- Trademark availability
- App Store name availability
- Google Play name availability
- Domain availability
- Social media handle availability

Do not assume that a coined name is automatically legally available.

---

# 33. MVP Definition

The first usable version should contain:

- Authentication
- Onboarding
- Dashboard
- Accounts
- Categories
- Income
- Expenses
- Transfers
- Transactions
- Basic budgets
- Basic analytics
- Supabase database
- Basic offline storage
- Dark mode
- Responsive Android/Windows UI

Do not delay the MVP by implementing every advanced feature.

---

# 34. First Development Task

Start with:

1. Install Flutter.
2. Configure Flutter in VS Code.
3. Configure Android development.
4. Configure Windows development.
5. Create the Finora Flutter project.
6. Initialize Git.
7. Create GitHub repository.
8. Add required dependencies.
9. Create the project architecture.
10. Configure Supabase.
11. Create the database schema.
12. Implement authentication.
13. Run `flutter analyze`.
14. Run tests.
15. Test on a physical Android device.

iOS builds should be tested on macOS/Xcode when that environment is available.

---

# 35. Development Command Reference

Create project:

```bash
flutter create finora
```

Enter project:

```bash
cd finora
```

Check Flutter:

```bash
flutter doctor
```

List devices:

```bash
flutter devices
```

Run application:

```bash
flutter run
```

Run Windows:

```bash
flutter run -d windows
```

Analyze:

```bash
flutter analyze
```

Test:

```bash
flutter test
```

Get dependencies:

```bash
flutter pub get
```

---

# 36. Final Development Rule

Build Finora as a real production-quality application.

Do not optimize for:

> "How quickly can AI generate code?"

Optimize for:

> "How reliably can we build, test, maintain and extend this application?"

GitHub Copilot is the implementation assistant.

The project architecture, database model, security model, UX decisions and feature boundaries must remain deliberate and controlled.
