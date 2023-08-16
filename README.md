# matlab-templates

Matlab-Templates is a collection of functions for quickly generating pre-edited matlab files 
for specific use cases: creating new classes, new tests...
It is based on the 'tedit' function, originally written by Peter Bodin.

The main functions are:

* **newClass**: create a new file containing a class definition template
* **newTest**: create a new file containing a minimal implementation for running unit tests
* **newEnum**: create a new file containing a minimal implementation for an enumeration class

Each function has to be called with the name of the item to create. 
This creates a new file (based on the item name), and opens the editor 
with a pre-edited header and code structure.
In particular, author name, copyright information, date of creation... are automatically populated
based on the templates defined in the 'newXXX' functions.

## Installation

The library is composed of a single directory containing all the necessary functions. 
The installation can be performed by simply cloning (or extracting the archive), 
and adding the path to the library to the Matlab path list.

## Creating a new class

The newClass function can be used to create a new file containing a class definition.

    newClass(NEWCLASSNAME) 

The new file contains the following code patterns:

* a header with pre-edited information
* property definition
* a constructor stub
* space for specific methods

You need to edit the different files for updating user-specific information (author name, contact email, copyright notice...). 

### Class pattern example

The following is the result of the creation of a new file called `SampleClass.m`, defining the class `SampleClass`, using the command  `newClass('SampleClass')`:

```matlab
    classdef SampleClass < handle
    % One-line description here, please.
    %
    %   Class SampleClass
    %
    %   Example
    %   SampleClass
    %
    %   See also
    %
    
    % ------
    % Author: David Legland
    % e-mail: david.legland@inrae.fr
    % Created: 2020-12-23,    using Matlab 9.8.0.1323502 (R2020a)
    % Copyright 2020 INRAE - BIA-BIBS.
   
   
    %% Properties
    properties
    end % end properties
    
    
    %% Constructor
    methods
        function obj = SampleClass(varargin)
            % Constructor for SampleClass class.
    
        end
    
    end % end constructors
    
    
    %% Methods
    methods
    end % end methods
    
    end % end classdef
```


## Creating new test

The newTest function can be used to create a new file containing a minimal implementation for running unit tests.

    newTest(FUNCTIONTOTEST) 

The following is the result of the command `newTest('foo')`:

```matlab
    function tests = test_foo
    % Test suite for the file foo.
    %
    %   Test suite for the file foo
    %
    %   Example
    %   test_foo
    %
    %   See also
    %     foo
    
    % ------
    % Author: David Legland
    % e-mail: david.legland@inrae.fr
    % Created: 2021-09-10,    using Matlab 9.10.0.1684407 (R2021a) Update 3
    % Copyright 2021 INRAE - BIA-BIBS.
    
    tests = functiontests(localfunctions);
    
    function test_Simple(testCase) %#ok<*DEFNU>
    % Test call of function without argument.
    foo();
    value = 10;
    assertEqual(testCase, value, 10);
```

