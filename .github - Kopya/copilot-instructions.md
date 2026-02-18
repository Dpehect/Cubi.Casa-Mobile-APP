# CubiCasa Flutter - Copilot Instructions

## Project Overview
This is a professional Flutter application for creating 2D & 3D floor plans. The project follows clean architecture principles with proper separation of concerns.

## Architecture Layers

### Data Layer (repositories/)
- Implements data access patterns
- Communicates with API service
- Abstracts data sources

### Domain Layer (models/)
- Contains data models
- Defines business entities
- Pure Dart objects

### Presentation Layer (screens/, widgets/)
- UI screens
- Reusable widgets
- State management with Riverpod

### Service Layer (services/)
- Business logic
- External service integration
- Utility services

## Code Style Guidelines

### Naming Conventions
- Classes: PascalCase
- Functions/Variables: camelCase
- Constants: camelCase or UPPER_SNAKE_CASE for compile-time constants
- Private members: prefix with underscore (_)

### File Organization
- One class per file (exceptions for related small classes)
- Index files for organizing exports
- Separate concerns by feature/functionality

### Best Practices
- Always use const constructors where applicable
- Prefer composition over inheritance
- Avoid deep nesting (max 3 levels)
- Use Riverpod for state management
- Handle errors gracefully with try-catch
- Write self-documenting code with clear variable names

## Package Structure

```
lib/
├── main.dart              - Entry point
├── config/                - App configuration
├── models/                - Data models
├── screens/               - UI screens
├── widgets/               - Reusable components
├── services/              - Business logic
├── providers/             - Riverpod providers
├── repositories/          - Data access
├── network/               - API integration
├── theme/                 - UI theming
├── constants/             - App constants
├── utils/                 - Utility functions
├── extensions/            - Dart extensions
├── helpers/               - Helper functions
└── assets/                - Static files
```

## Adding New Features

### 1. Create Model
- Add model in `models/` directory
- Include JSON serialization methods

### 2. Create Service (if needed)
- Add service in `services/` directory
- Implement business logic

### 3. Create Repository
- Add repository in `repositories/impl/` directory
- Define abstract class and implementation

### 4. Create Provider
- Add provider in `providers/` directory
- Use Riverpod StateNotifier pattern

### 5. Create Screen
- Add screen in `screens/` directory with proper organization
- Integrate with providers

### 6. Add Widgets
- Reusable widgets in `widgets/` directory
- Keep components small and focused

## Testing Patterns

### Unit Tests
- Test services and repositories
- Place in `test/unit/` directory
- Use mockito for dependencies

### Widget Tests
- Test individual widgets
- Place in `test/widget/` directory
- Use WidgetTester

### Integration Tests
- Test full user flows
- Place in `test/integration/` directory

## Common Tasks

### Adding API Endpoint
1. Add endpoint to `ApiEndpoints` in `constants/app_constants.dart`
2. Create repository method using ApiService
3. Create Riverpod provider
4. Use in appropriate screen

### Adding New Screen
1. Create screen class in appropriate subdirectory
2. Add route to `config/router.dart`
3. Create provider if state management needed
4. Add navigation logic

### Adding Validation
1. Add validator function in `helpers/validators.dart`
2. Use in form fields via `TextInputField` widget
3. Display error messages

### Error Handling
- Catch DioException in API calls
- Log errors using Logger utility
- Show user-friendly error dialogs
- Retry logic for network errors

## Performance Optimization

- Use `const` constructors
- Avoid rebuilds with proper widget boundaries
- Use `RepaintBoundary` for complex widgets
- Optimize images (compress in `ImageService`)
- Use `ListView.builder` for long lists
- Cache API responses using `CacheService`

## Important: Before Submitting Code

### Code Quality
- Run `flutter analyze`
- Run `flutter format .`
- Fix linting issues

### Testing
- Write unit tests for new logic
- Test on both Android and iOS
- Check performance with Profiler

### Documentation
- Add comments for complex logic
- Update this file if adding new patterns
- Keep README.md updated

## Troubleshooting

### Common Issues
1. Build failures: Check gradle cache and dependencies
2. Runtime errors: Check logs in debug console
3. Performance issues: Use Flutter DevTools Profiler
4. API errors: Verify endpoints and authentication tokens
