# Budget App - Project Plan & Proposal

## Project Overview

A YNAB-inspired budget app with a focus on ease of use and automatic calculations for personal finance tracking.

### Goals
1. Free personal budgeting tool for tracking finances
2. Easy-to-use interface for people who want simple finance tracking
3. Valuable through automation and built-in calculations

---

## MVP Feature Set

### Core Features (Phase 1)
1. **Planning** - Category groups, categories, and basic "ready to assign" bucket
2. **Spending** - Manual transaction entry with category assignment
3. **Accounts** - Manual account creation and balance tracking

### Deferred to Future Releases
- Target types (set-aside, fill up to, long-term savings)
- Bank account linking
- Account reconciliation
- Reporting/analytics (Reflect epic)
- Credit card debt automation
- Transaction pending/cleared states
- Home page customization (pinned categories)

---

## Data Models

### 1. User
- `id` (UUID)
- `email` (String)
- `password` (String, encrypted)
- `createdAt` (Timestamp)

### 2. Account
- `id` (UUID)
- `userId` (UUID, FK)
- `name` (String)
- `type` (Enum: CHECKING, SAVINGS, CREDIT_CARD)
- `balance` (BigDecimal)
- `createdAt` (Timestamp)

### 3. CategoryGroup
- `id` (UUID)
- `userId` (UUID, FK)
- `name` (String)
- `sortOrder` (Integer)

### 4. Category
- `id` (UUID)
- `categoryGroupId` (UUID, FK)
- `name` (String)
- `assigned` (BigDecimal) - amount assigned this month
- `activity` (BigDecimal) - spending this month
- `available` (BigDecimal) - assigned + activity
- `sortOrder` (Integer)

### 5. Transaction
- `id` (UUID)
- `accountId` (UUID, FK)
- `categoryId` (UUID, FK, nullable)
- `date` (LocalDate)
- `payee` (String)
- `amount` (BigDecimal) - positive for inflow, negative for outflow
- `memo` (String, nullable)
- `createdAt` (Timestamp)

### 6. MonthlyBudget
- `id` (UUID)
- `userId` (UUID, FK)
- `month` (YearMonth)
- `income` (BigDecimal)
- `readyToAssign` (BigDecimal)

---

## Project Structure

budget-app/ ├── backend/ (Spring Boot) │ ├── src/main/java/com/hbelange/budgetapp/ │ │ ├── config/ │ │ ├── controller/ │ │ ├── service/ │ │ ├── repository/ │ │ ├── model/ │ │ ├── dto/ │ │ └── exception/ │ ├── src/main/resources/ │ └── pom.xml ├── frontend/ (Angular - separate directory) └── docker-compose.yml (for PostgreSQL)

---

## Technology Stack

- **Backend**: Spring Boot
- **Frontend**: Angular
- **Database**: PostgreSQL
- **Build Tool**: Maven
- **Containerization**: Docker
- **Testing**: JUnit, Mockito (backend), Jasmine/Karma (frontend)

---

## Development Phases

### Phase 1: Infrastructure Setup
- Docker setup for PostgreSQL
- Spring Boot project skeleton
- CI/CD pipeline setup (GitHub Actions)
- Basic deployment configuration
- Database migration setup (Flyway)

### Phase 2: User Management
- Create User entity and repository
- Implement user service with basic authentication
- Build user registration/login endpoints
- **Write unit tests for user service**
- **Write integration tests for user endpoints**

### Phase 3: Account Management
- Create Account entity and repository
- Implement account service (CRUD operations)
- Build account REST endpoints
- **Write unit tests for account service**
- **Write integration tests for account endpoints**

### Phase 4: Category Management
- Create CategoryGroup and Category entities
- Implement category service (CRUD operations)
- Build category REST endpoints
- **Write unit tests for category service**
- **Write integration tests for category endpoints**

### Phase 5: Transaction Management
- Create Transaction entity and repository
- Implement transaction service with category assignment logic
- Build transaction REST endpoints
- Implement budget calculation logic
- **Write unit tests for transaction service**
- **Write integration tests for transaction endpoints**

### Phase 6: Frontend Development
- Set up Angular project structure
- Create account management UI
- Create category management UI
- Create transaction entry UI
- Create budget planning view
- **Write component tests for each feature**
- **Write E2E tests for critical user flows**

### Phase 7: Integration & Polish
- Final integration testing
- Performance testing
- Security review
- Documentation
- Production deployment verification

---

## Questions & Decisions

1. **Authentication**: Start with basic authentication or implement OAuth2/JWT from the beginning?
   - **Recommendation**: Basic auth for MVP, migrate to JWT later

2. **Multi-tenancy**: Single-user for MVP or multi-user from the start?
   - **Recommendation**: Multi-user from start (minimal overhead with proper userId FKs)

3. **Database migrations**: Use Flyway or Liquibase for schema versioning?
   - **Recommendation**: Flyway (simpler, better Spring Boot integration)

4. **API Design**: RESTful or GraphQL?
   - **Recommendation**: RESTful for MVP

---

## Testing Strategy

- **Unit Tests**: Written immediately after each service implementation
- **Integration Tests**: Written immediately after each controller implementation
- **Test Coverage Goal**: Minimum 80% code coverage
- **Continuous Testing**: All tests run on every commit via CI/CD

---

## Next Steps

1. ✅ Review and approve this proposal
2. Set up infrastructure (Docker, CI/CD, deployment)
3. Implement features iteratively with tests
4. Deploy continuously to test environment
5. Release MVP to production

---

**Status**: Awaiting approval to proceed with implementation