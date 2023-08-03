import 'dart:ffi'; // Import the FFI library
import 'package:ffi/ffi.dart';

// Define the 'hello' function signature using typedef
typedef NumberOneFunc = Int32 Function();
typedef NumberOne = int Function();
typedef StringOneFunc = Pointer<Utf8> Function();
typedef StringOne = Pointer<Utf8> Function();

// Load the shared library that contains the native function
final DynamicLibrary nativeLib = DynamicLibrary.open('libhello.so');
final NumberOne hello = nativeLib
    .lookup<NativeFunction<NumberOneFunc>>('numberOne')
    .asFunction<NumberOne>();

final StringOne helloString = nativeLib
    .lookup<NativeFunction<StringOneFunc>>('stringOne')
    .asFunction<StringOne>();
