# Ganary

Ganary (alias for "GMS Runtime Canary", and henceforth abbreviated as "GRC") is a GMS 2.3 project that uses [Olympus](https://github.com/bscotch/olympus) to perform regression tests for GMS runtimes.

When a new runtime is released, it should pass all existing tests to confirm that known issues are fixed.

If new issues are discovered, they can be added as Olympus tests to ensure that they are covered going forward.

## How to use

### Default config

Under this config, the tester has 3 seconds to enter inputs through mouse/touchscreen/gamepad to reset the Olympus record to start the test fresh. If no input is detected, the test will load unfinished Olympus record if there are any in the saves directory as a result of silent crashes.

### Dev Config or Debug mode

Under this config, the tests will always start fresh, and the Olympus async test that requires user feedback are skipped.

## Project Organization and How to Add Tests

All tests are registered in these script resources in the `Ganary/Test_registration` group in the yyp project:

1. `grc_register_sync_function_tests`: For tests that are added through the `olympus_add_test()` API
2. `grc_register_async_function_tests`: For tests that are added through the `olympus_add_async_test()` API
3. `grc_register_manual_tests`: For tests that are added through the `olympus_add_async_test_with_user_feedback()` API
4. `grc_register_compile_tests`: For tests that would prevent the project from building

These scripts are then called in `o_grc_test_starter`'s `Create` event in the `_function_to_add_tests_and_hooks()` instance function.

You can add your tests to these script resources, or you can create a new script and add it to the `_function_to_add_tests_and_hooks()` function and move the script to the `Ganary/Test_registration` group.

If you add resouces such as sprites, audios, and shaders, move them to the `Ganary/misc_resources` group. If you add objects, move them to `Ganary/Objects`'s subgroups based on their test type.
