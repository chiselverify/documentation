# ChiselVerify NorCaS 2021 Talk  
Hi my name is _Andrew Dobis_ and I'm a Masters student in Computer Science at ETH Zurich. Today, I'm here to present __ChiselVerify__, which is a Hardware verification library for Chisel. I worked on this project along with Tjark Petersen, Hans Damsgaard, Kasper Hesse, Enrico Tolotto, Simon Andersen, 
and Martin Schoeberl over at the _Technical University of Denmark_, as well as Richard Lin from _UC Berkeley_. 
  
## Outline  
Let's start by giving a brief overview of the presentation. First off, I'm going to introduce the necessary background needed for our work. Then I'll move on to discussing the current solutions when it comes to verifying a Chisel design, which will then lead to the motivation behind our work. Finally I'll present our solution for verification in Chisel, and evaluate it by comparing it to a common standardized verfication methodology named UVM.   
  
## Background  
Let's now present the necessary background for our work.  

### Verification  
Let's start by setting what we consider as Verification of digital systems:
Verification relates to work the testing of a design before it has been taped out. But more specifically, _verifying a desing means guaranteeing that the expected features, as described in the specification, have been correctly implemented and have the correct behavior._   
In other wordsm Verification tools are what allow to verify that the tests we are writing “test the right things”.  
  
Let's now talk about the Universal Verification Methodology or UVM. This is a standardized method for writting tests in SystemVerilog and allows one to write reusable testbenches. This is one of the most common verification methodologies used today.   
  
### Verification tools  
Let's now describe the different verification tools that exist.   
First there's Functional Coverage, which a Qualitative and fine-grained coverage metric. This means that, in contrast to a quantitative metric, Functional Coverage will give the user progress information about the specific features that they are testing, rather than e.g. amount of code being tested.  
  
Another important tool is Constrained Random Verification or CRV. This enables the creation of random variables which generate values that satisfy a set of constraints. With CRV, one can write relatively simple test cases capable of covering many of the Device Under Test or DUT' s functionalities thanks to well driven valid inputs.  
  
### Chisel   
Finally, let's present the environment we will be working in, which is Chisel.  
Chisel is a Hardware Construction Language embedded in Scala, which allows for Object-Oriented and Functional programming to be used in the scope of digital design. Chisel works by compiling to either an intermediate representation called FIRRTL, which can then be simulated using an execution engine like Treadle, or all the way to Verilog. The output Verilog can then be simulated using any Verilog simulator, for example verilator, or can be synthesised.
  
## Current Solutions 
This now brings us to the current solutions for verifying Chisel designs.  
  
### Overview of the current solutions  

Chisel designs can be tested using essentially two main approaches: testing the Chisel code and testing the output Verilog.   
When it comes to testing the Chisel code, we mostly have two main options:   

- __ChiselTest__, which is great for more "traditional" test-benches that rely on setting inputs, and comparing outputs to a golden model.  
- __ScalaTest__, which is really just testing the Scala code as if it was software and doesn't really fit for hardware.  

Now when it comes to testing the output Verilog description, we have a couple more powerful options such as:  

-  __SystemVerilog__, which is an Object-Oriented non-synthesisable extension to Verilog.  
- __UVM__, which we presented earlier.  

### Current solutions: what’s missing? 
Other solutions do exists, like Rfuzz or chisel-formal, however they do not cover the functionalities we are trying to achieve in our solution.   

The current solutions do work, but can definetly be improved upon. ChiselTest, for starters, doesn't really have any verification functionalities, i.e. ways to guarentee the corectness of a test. It's also lacking in automated testing capabilities. SystemVerilog with UVM, however, does propose these missing functionalities, but has the problem of being extremely verbose and requires us to rely on multiple languages in order to test our desing, which isn't ideal.   
   
## Motivation   
This brings us to the motivation behind our work.   
  
### Motivation: Current lack of verification tools  
So far Chisel doesn’t have any “native” tools that allow the easy use of verification functionalities. All existing tools require the use of different languages or tools external to the Chisel/Scala ecosystem. Our goal is to provide Chisel with tools that are specifically tailored to the language, efficient to use and easy to learn. This is not currently the case of the most popular solution  which is SystemVerilog with UVM. 
  
## Our Solition: ChiselVerify
It is now time to present ChiselVerify, which is our solution to Chisel's lack of verification functionalities.    

### ChiselVerify: overview  
ChiselVerify is an extension of _ChiselTest_, which fills in the existing holes that the framework has in terms of verification features. This includes enabling:  
  
- Functional Coverage  
- Constrained Random Verification  
- Bus Functional Models  
- Timed Assertions  

This not only adds functionalities from SV that were missing in ChiselTest, but also improves upon them, enabling features like Timing related assertions or coverage, as well as purely conditional coverage constructs. 

## Functional Coverage   

Let's dive straight into it and start by talking about Functional Coverage with ChiselVerify.  
  
### Functional coverage: what is it?
Functional Coverage consists of defining what's called a __Verification Plan__, which is a representation of our DUT's expected behaviour. This is then `sampled` throughout a test-suite to gather covege information that is then compiled into a `CoverageReport`.
  
A __Verification Plan__, consists of a set of `CoverGroups` which themselves consit of `CoverPoints` which contain `Bins`. A Coverpoint's coverage %, is defined by the amount of `hits` each Bin gets.   
  
You can our paper for more details about the different characteristics our cover constructs and bins can have.  

Let's now quickly take a look at how all of this works.  

### How did we do it?  
There are two main elements:  

- the `CoverageDB`, which stores all of the bin-hitvalue mappings.  
- the `CoverageReporter`, which manages the DB, registers the Verification Plan and accesses the DUT when needed. This is what we will be using to create our __Verification Plan__.  

Let's now look at how to use our Functional Coverge tool.

### Functional Coverage API   
The API consists of two main elements:  

-  __Cover constructs__: Represent a feature of the DUT. These can be defined either by a single or by multiple DUT ports. Its behavior is then defined by the bins it contains.  
-  __Bins__: Repesent the definition of a part of a feature, specifically a certain behavior that a DUT port is expected to have. These are defined using value ranges or condition, and can contain timing information.  

### Using it  
  
Now let's use these elements together in an example. So we first start by creating a coverage reporter and then we can define our verification plan by using its `register` method.  

Once the verification plan is defined, we can start writing our normal ChiselTest test-bench and call our coverage reporter's `sample` method whenever our covered ports are updated (usually at every cycle).  

Once all of that is done, we generate our report and can also create a user-readable version using the `serialize` method, which will result in something looking like this.   
  
## Constrained Random Verification  
That's enough for coverage, now let's move on to Constrained Random Verification.     
  
### Constrained random Verification: What is it?
The idea here is to automate your tests by using constraint-driven randomized inputs. This means that we can give our DUT random inputs that are more meaningful than simply using uniform randomness.  
  
To enable this in Scala, we developped a `Constraint Programming Language` allowing the definition of random objects containing random variables and constraints. These random object define a _Constraint Satisfaction Problem_ wich is then solved using an existing CSP Solver named JaCoP.  
  
### How did we do it?  
To define a Random object, you have to create a Scala class that extends the `RandObj` trait, all while giving it a Model that is used as a database for the random generation.  
   
You can then define Random Variables or `RandVar` fields inside of said class using the `rand` function. These variables can either be cyclic, meaning they can't take the same value twice, or non-cyclic.
  
Constraints can then be defined either by using single constraints or constraint blocks.  
  
### What do we add
   
Here is a list of the different constraint operators that you can use, I won't go into too much detail, since they are all well documented in our's repository's wiki. One can define conditional constraints, which only consider a constraint if a given condition is met. These are created using the `IfCon` and `ElseC` constructs.  
  
Once all of the constraints and random variables are defined, we need to instantiate our random object inside of our test and then randomize it in order to get new values in each of our random variables. Of course, it is possible to define an unsolvable CSP in a Random Object, which is why the randomize method returns a Boolean, telling you wether or not your constaints were solvable.    
  
## Bus Functional Models
Let's briefly talk about an example bus functional model (BFM) we added to our library.   

### Bus functional model: what is it?    
The idea behind BFMs is to create an abstraction of the inner workings of a standardised interface in order to simplify writing test-benches. This means that rather than dealing with each individual signal in a standardized interface, we can simply work with _transactions_ instead.  
  
As an example of this, we chose to develop a BFM for the AXI4 Bus interface. AXI4 is an interface containing 3 write channels and two read channels, each channel having its own ready-valid interface. You thus end up with 25 signals to handle for a write and 20 for a read.    

### Bus functional model: How to use it  
Instead of that, we can define a FunctionalManager which allows us to use a `ReadTransaction` and a `WriteTransaction` to communicate via the AXI interface. All of the inner workings are then handled by the BFM itself.  
  
The idea is to use this as an example for any other BFM that one would want to create.  
  
## Timed Assertions  
Finally, let's quickly talk about Timed Assertions.   

### Timed Assertions: Brief Overview  
These allow to create predicated assertions that take into account certain timing delays. The delays can be defined using different types of delays. 
Given a delay of x cycles:  

- __Exactly__: Assertion is true in exactly x cycles.
- __Eventually__: Assertion is true at least once in the next x cycles.   
- __Always__: Assertion is true every cycle for the next x cycles. 
- __Never__: Assertion isn’t true at any cycle for the next x cycles.  
  
### Using it  
The interface is inspired by ScalaTest's `eventually` method. Here we can call the assertion method using their timing type as the function. As for the parameters, `d` is the delay in cycles, `msg` is the assertion error message, `cond` is the function, given as a lambda and the dut must be implicitly defined somewhere in the test. Here is an example of how to use each timed assertion.   
  
## Conclusion  
So that's what the current state of `ChiselVerify` looks like. `ChiselVerify` brings hardware verification to the Chisel-Scala ecosystem. As you might have noticed during the presentation, the syntax used by `ChiselVerify` is a lot more  efficient and lightweight than using SystemVerilog with UVM.   
  
This is demonstrated by testing a MinHeap Queue both with ChiselVerify and with UVM and comparing the number of lines of code (LOC) needed to achieve the same functionaly. For example, the functional coverage was gathered using 24 LOC for ChiselVerify and 94 LOC for UVM (only counting the UVM subsrciber and not all of the UVM structural code).   
  
On top of that ChiselVerify provide more modern features that aren't present in SV such as Timing-based verification and purely conditional coverage. We also want to add that `ChiselVerify` can be used to verify non-Chisel designs as well thanks to Chisel's blackboxing features.  

## References  
Here are a few references to the main work that inspired `ChiselVerify`.   
 
## Getting started  
This project is of course fully open-source and can be found on github. If you want to get started using our library, the best way is by checking out our wiki, which contains an in-depth tutorial on how to use the different functionalities proposed by our library. `ChiselVerify` is published on Maven, so you can use it without a problem by adding a single line to your project's `build.sbt` file.  
  
## Questions?
Thank you very much for listening and now are there any questions?  
  
  
