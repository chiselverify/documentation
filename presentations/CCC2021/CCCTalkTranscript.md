# ChiselVerify CCC_2021 Talk  
Hi everyone, my name is _Andrew Dobis_ and I'm here to present __ChiselVerify__, which is a Hardware verification library for Chisel. This is currently being developped by a group of people over at the _Technical University of Denmark_ as well as myself.  
  
## Outline  
Let's start by giving a quick outline of the presentation, so that you know what to expect. First off, I'm going to briefly introduce the notion of _Verification_ or at least what we consider as _Verification_. Then I'll move on to discussing the current solutions when it comes to verifying a Chisel design. Finally, and this will take up most of the presentation, I'll present our solution for verification in Chisel. So let's get started!  
  
## Hardware Verification : What & Why?  
Let's start by defining what we consider as hardware verificaiton:   

_Verifying a desing means guaranteeing that the expected features, as described in the specification, have been correctly implemented and have the correct behavior._   
  
This definition can be split into two methods:    

- __Verification__, which is when we test before tapeing-out.  
- __Validation__, which is testing after tapeing-out.    
	
We are solely going to focus on the first one, i.e. verification. Now why is it useful to test a design before spending a lot of money tapeing it out? Well obviously to save time and money. Now this thus requires we thus efficient tools allowing us to do so. These tools are currently lacking in the Chisel ecosystem and many people are noticing that, since we are seeing more and more projects like ours pop up. But let's start by talking about the current well-established solutions.  
  
## Current Solutions 
Chisel designs can be tested using essentially two main approaches: testing the Chisel code and testing the output Verilog.   
When it comes to testing the Chisel code, we mostly have two main options:   

- __ChiselTest__, which is great for more "traditional" test-benches that rely on setting inputs, and comparing outputs to a golden model.  
- __ScalaTest__, which is really just testing the Scala code as if it was software and doesn't really fit for hardware.  

Now when it comes to testing the output Verilog description, we have a couple more powerful options such as:  

-  __SystemVerilog__, which is an Object-Oriented non-synthesisable extension to Verilog.  
- __UVM__, which is a sort of methodology for writing reusable test-benches in SV.  

Now these current solutions do work, but can definetly be improved upon. ChiselTest, for starters, doesn't really have any verification functionalities, i.e. ways to guarentee the corectness of a test. It's also lacking in automated testing capabilities. SystemVerilog with UVM, however, does propose these missing functionalities, but has the problem of being extremely verbose and requires us to rely on multiple languages in order to test our desing, which isn't ideal.    
  
## Our Solition: ChiselVerify

Our solution to this, is to develop a library, as an extension of _ChiselTest_, filling in the existing holes that the framework has in terms of verification features. This includes enabling:  
  
- Functional Coverage  
- Constrained Random Verification  
- Bus Functional Models  
- Timed Assertions  

This thus not only adds functionalities from SV that were missing in ChiselTest, but also improves upon them, enabling features like Timing related assertions or coverage, as well as purely conditional coverage constructs. Let's dive straight into it and start by talking about Functional Coverage with ChiselVerify.  
  
## Functional Coverage   

So there are two main ways to gather coverage information about a test suite:  

-  __Statement Coverage__, which gives us a _quantitave_ coverage metric. This tells us _"How much code has been tested?"_.  
-  __Functional Coverage__, which gives us a _qualitative_ coverage metric, telling us _"Which features have been tested?"_.  

### What is it?
Functional Coverage consists of defining what's called a __Verification Plan__, which is a representation of our DUT's expected behaviour. This is then `sampled` throughout a test-suite to gather covege information that is then compiled into a `CoverageReport`.
  
A __Verification Plan__, consists of a set of `CoverGroups` which themselves consit of `CoverPoints` which contain `Bins`. A Coverpoint's coverage %, is defined by the amount of `hits` each Bin gets. In our library, there are four types of cover points:   

- Regular `CoverPoint`, which are the same as the SV version of a CoverPoint, meaning that they contain bins that are defined using a range. A hit is then considered if a value in the range is sampled.  
- `CoverConditions`, which is the same idea as a CoverPoint, but a hit is only considered once a user defined predicate is satisfied by a sampled value.  
- `CrossPoint`, which defines a relation between many different points. Here a hit is considered when each port in the `CrossPoint` is sampled with a value that is contained within its associated range.  
- `TimedCross`, which defines a Cross relation between two ports with an added delay, meaning that the first port is sampled a given number of cycles before the second port. There are also three other delay types which each define their one way of considering a hit.  

Let's now quickly take a look at how we implemented this.  

### How did we do it?  
There are two main elements:  

- the `CoverageDB`, which stores all of the bin-hitvalue mappings.  
- the `CoverageReporter`, which manages the DB, registers the Verification Plan and accesses the DUT when needed. This is what we will be using to create our __Verification Plan__.  

Let's now look at how to use our Functional Coverge tool.

### Functional Coverage API   
The API is quite simple and generaly follow the same structure throughout the different point types: `PointType(name, ports)(bins/conditions)`.  
  
Then here's an overview of the interfaces for all of our PointTypes. Now let's use these elements together in an example. So we first start by creating a coverage reporter and then we can define our verification plan by using its `register` method.  

Once the verification plan is defined, we can start writing our normal ChiselTest test-bench and call our coverage reporter's `sample` method whenever our covered ports are updated (usually at every cycle).  

Once all of that is done, we can print out our report by using the `printReport` method, which will result in something looking like this.  
> Maybe also explain the structure of the report if time permits.  
  
## Constrained Random Verification  
That's enough for coverage, now let's move on to Constrained Random Verification. The idea here is to automote your tests by using constraint-driven randomized inputs. This means that we can give our DUT random inputs that are more meaningful than simply using uniform randomness.  
  
To enable this in Scala, we developped a `Constraint Programming Language` allowing the definition of random objects containing random variables and constraints. These random object define a _Constraint Satisfaction Problem_ wich is then solved using an existing CSP Solver named JaCoP.  
  
### SystemVerilog
Let's first look at how constraint programming is done in a well established language like SystemVerilog. The idea is the same, we first start by defining a Random Object (here we called it `frame_t`). We then define random varibles as fields of the random object. These will be used to generate and store random values. Random Variables can be created using either:  
  
- `rand`, which defines a regular random variable that can take any bit value it wants.  
- `randc`, which defines a cyclic random variable that can't take the same value twice, before its used up all of its possible values.  

Once our random variables are defined, we can create constraints on them, which will effect the values that they can take. These are then grouped together using a `constraint` block.  
  
### How did we do it?  
To define a Random object, you have to create a Scala class that extends the `RandObj` trait, all while giving it a Model that is used as a database for the random generation.  
   
You can then define `Rand` or `Randc` fields inside of said class, which represent the random variables. The main difference with SystemVerilog here is that we have to define a range of possible values for each random variable.  
  
Constraints can then be defined either by using single constraints or constraint blocks. Usually, most of our constraint operators are preceded by the # sign.  
  
As you can see the syntax is very similar to the one used in SystemVerilog, this was in order to lessen the learning curve for people wanting to use our library coming from SystemVerilog.  
   
Here is a list of the different constraint operators that you can use, I won't go into too much detail, since they are all well documented in our's repository's wiki. We should also add that one can define conditional constraints, which only consider a constraint if a given condition is met. These are created using the `IfCon` and `ElseC` constructs.  
  
Once all of the constraints and random variables are defined, we need to instantiate our random object inside of our test and then randomize it in order to get new values in each of our random variables. Of course, it is possible to define an unsolvable CSP in a Random Object, which is why the randomize method returns a Boolean, telling you wether or not your constaints were solvable.   
  
### Using it  
Let's quickly look at a example of how to use the CRV tool in a test. We start by creating a random object (on the left) in which we define our random variables and constraints. For example in `single` we define a constraint that forces `payload`'s head to take a random value within the range defined by the subtraction of `len`'s and `size`'s bounds.  
  
Once the object is defined, we need to instantiate it and then randomize it. We can then use the values however we'd like. For example, we could have a Coverage-based mutational test, which uses constraints defined in terms of functional coverage results to drive the DUT's inputs. The idea would be to try new constraints until we get closer an closer to a target coverage amount. This would allow us to check the correctness of a test without having to go through every possible combination of values.  
  
## Bus Functional Models
Let's briefly talk about an example bus functional model (BFM) we added to our library. The idea behind BFMs is to create an abstraction of the inner workings of a standardised interface in order to simplify writing test-benches. This means that rather than dealing with each individual signal in a standardized interface, we can simply work with _transactions_ instead.  
  
As an example of this, we chose to develop a BFM for the AXI4 Bus interface. AXI4 is an interface containing 3 write channels and two read channels, each channel having its own ready-valid interface. You thus end up with 25 signals to handle for a write and 20 for a read. Instead of that, we can work use a `ReadTransaction` and a `WriteTransaction`. All of the inner workings are then handled by the BFM itself.  
  
The idea is to use this as an example for any other BFM that one would want to create.  
  
## Timed Assertions  
Finally, let's quickly talk about Timed Assertions. These allow to create predicated assertions that take into account certain timing delays. The delays can be defined using different types of delays. 
Given a delay of x cycles:  

- __Exactly__: Assertion is true in exactly x cycles.
- __Eventually__: Assertion is true at least once in the next x cycles.   
- __Always__: Assertion is true every cycle for the next x cycles. 
- __Never__: Assertion isn’t true at any cycle for the next x cycles.

There are two types of timed assertions: `AssertTimed` and `ExpectTimed`. `ExpectTimed` uses _ChiselTest_'s `expect` method whereas`AssertTimed` functions using scala's software assertion. This makes `ExpectTimed` maybe a bit more adapted for hardware, on top of the fact that the syntax is a bit lighter.  
  
### Using it  
The interface is very similar to their non-timed counterparts, where `message` is what will be displayed in case of a failed assertion. Here's an example where we use the same assertion with different delays and with `AssertTimed` and `ExpectTimed`.  
  
## Conclusion  
So that's what the current state of `ChiselVerify` looks like. `ChiselVerify` brings hardware verification to the Chisel-Scala ecosystem. As you might have noticed during the presentation, the syntax used by `ChiselVerify` is a lot more  efficient and lightweight than using SystemVerilog with UVM and provides many of the same functionalities as well as more modern ones that aren't present in SV such as Timing-based verification and purely conditional coverage. We also want to add that `ChiselVerify` can be used to verify non-Chisel designs as well thanks to Chisel's blackboxing features.  

## References  
Here are a few references to the main work that inspired `ChiselVerify`.   
 
## Getting started  
This project is of course fully open-source and can be found on github. If you want to get started using our library, the best way is by checking out our wiki, which contains an in-depth tutorial on how to use the different functionalities proposed by our library. `ChiselVerify` is published on Maven, so you can use it without a problem by adding a single line to your project's `build.sbt` file.  
  
## Questions?
Thank you very much for listening and now are there any questions?  
  
  
