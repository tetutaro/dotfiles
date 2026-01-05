# General

Using following MCP services if needed.

* context7: Refer the latest documentation of 3rd party Python Libraries.
* serena: Perform project-wide searches for symbol definitions and references (functions, classes, variables) with high precision.
* gemini-cli: When investigating / searching for information, use gemini to access Gemini protocol resources.

# Languages

## TypeScript

* **Type Safety**: Always use proper type annotations. Avoid 'any' type unless absolutely necessary.
* **Interface vs Type**: Use interfaces for objects that can be extended, types for unions and intersections.
* **Nullability**: Use optional chaining (?.) and nullish coalescing (??) operators for null safety.
* **Async Code**: Use async/await pattern rather than raw promises. Always handle rejections.
* **Generics**: Implement generic types for reusable components and functions.
* **Module System**: Use ES modules (import/export). Avoid namespace syntax.
* **Config**: Include tsconfig.json with strict mode enabled if necessary.
* **Code Organization**: Follow feature-based structure. Group related functionality.
* **Testing**: Include Jest/Mocha test cases with proper mocking.
* **Linting**: Follow ESLint + Prettier standards with consistent spacing and semicolons.
* Include comprehensive type definitions and avoid type assertions.

## React for Websites and Web Apps:

* Complete, self-contained code within the single immersive.
* Use App as the main, default-exported component.
* Use functional components, hooks, and modern patterns.
* Use Tailwind CSS (assumed to be available; no import needed).
* For game icons, use font-awesome (chess rooks, queen etc.), phosphor icons (pacman ghosts) or create icons using inline SVG.
* **lucide-react**: Use for web page icons. Verify icon availability. Use inline SVGs if needed.
* **shadcn/ui**: Use for UI components and recharts for Charts.
* **State Management**: Prefer React Context or Zustand.
* No ReactDOM.render() or render().
* **Navigation**: Use switch case for multi-page apps (no router or Link).
* **Links**: Use regular HTML format: <script src="{https link}"></script>.
* Ensure there are no Cumulative Layout Shifts (CLS)

## Python

* **Code Style**: Version 3.11 or latest. Follow Google guidelines for naming and formatting.
* **Type Hints**: Use type annotations with mypy compatibility. Require type hints for all variables.
* **Explicit Returns and Type Hints**: Every Python function must include an explicit return type hint. If a function returns nothing, you must specify `-> None` in the function signature and explicitly write `return` at the end of the function body. Implicit returns are strictly prohibited.
* **Explicit Function Calling**: When calling functions, explicitly include the parameter names for every argument passed.
* **Documentation**: Basically not need to generate docstrings. If specified, use Google style docstrings for functions and classes.
* **Error Handling**: Use specific exception types with proper context managers.
* **OOP**: Follow SOLID principles. Use dataclasses or named tuples for data containers.
* **Functional Features**: Utilize list comprehensions, generators, and higher-order functions.
* **Imports**: Organize imports by standard library, third-party, and local modules.
* **Asynchronous Code**: Use async/await with asyncio for I/O-bound operations.
* **Testing**: Include pytest tests with fixtures and parameterization.
* **Logging**: Implement proper logging instead of print statements.
* **Context Managers**: Use with statements for resource management.
* **For Data Science**: Follow polars, pandas, numpy, and matplotlib best practices.
* Include proper error messages and validation for user inputs.

# General Code (All Languages):

* **Completeness**: Include all necessary code to run independently.
* **Comments**: No need for comments that can be understood by reading the code.
* **Error Handling**: Use try/catch and error boundaries.
* **No Placeholders**: Never use ....
* **Test**: Basically, you do not need to generate test code.
* Write production-level code with excellent readability. Respond after careful deliberation and after confirming that there are no problems. If there is a potential problem, be sure to specify it.
