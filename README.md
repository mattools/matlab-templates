# matlab-templates

Matlab-Templates is a collection of functions for quickly generating pre-edited matlab files 
for specific use cases: creating new classes, new tests...
It is based on the 'tedit' function, originally written by Peter Bodin.

Each function in the template has a name in the 'newXXX' format. 
When the function is called with the name of the item, a new file is created, and the editor opens
with a pre-edited header and code structure.
In particular, author name, copyright information, date of creation... are automatically updated.
The templates can be modified by editing the 'newXXX' functions.


## Main functions

### Creating new class

The newClass function can be used to create a new file containing a class definition.

    newClass(NEWCLASSNAME) 

The new file contains the following code patterns:

* a header with pre-edited information
* property definition
* a constructor stub
* space for specific methods

### Creating new test

The newTest function can be used to create a new file containing a minimal implementation for running unit tests.

    newTest(FUNCTIONTOTEST) 


## Class pattern example

The following is the result of the creation of a new class called `SampleClass` , using the `newClass('SampleClass')`  command:

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


