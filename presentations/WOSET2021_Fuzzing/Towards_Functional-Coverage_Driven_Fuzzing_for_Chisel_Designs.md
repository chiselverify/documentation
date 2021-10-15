# Towards Functional-Coverage Driven Fuzzing for Chisel Designs  

Today I will be talking about our exploratory work done on Functional-Coverage Driven Fuzzing for Chisel Designs. I'm Andrew Dobis and this work was done along with Tjark Petersen and Martin Schoeberl over at the Technical University of Denmark.    
  
## Outline  
Let me start by giving a brief overview of the presentation. 
We will first start by presenting the motivation behind this project. 
After that we will introduce the necessary background on chisel and fuzzing.
Finally, we will describe our solution for fuzzing chisel designs, and talk about our inital experiments with the fuzzer.   
Please remember that this solution is still very much a work in progress.  
  
## Motivation  
The term "fuzzing" is often associated to software testing, but with the current move towards using software testing techniques for hardware, Fuzzing is slowly being introduced into the digital design ecosystem. 
This means, of course, that recent work has been done on Fuzzing for digital circtuis, however none of them have focused on using a hardware-centric metric, such as Functional coverage, to drive the fuzzing.  
  
Our goal with this project is thus:  

- _Explore_ the effects of driving fuzzing using a metric that inherently contains data about the Device Under Test (DUT).  

-  _Evaluate_ its impacts on the fuzzer's efficiency.  

## Background  
Before we go any further, I will quickly present some background on Chisel and fuzzing in general.  
Fuzzing refers to automated input generation driven by a certain metric. This allows for more effective randomized testing with the goal of exploring all, or most, interesting test cases without having to go through every possible input value.  

Then we have Chisel, which is a Hardware construction Language, embedded in Scala. It allows for the high-level description of digital circuits using Object-Oriented and Functional programming constructs. Chisel is compiled through an intermediate representation called FIRRTL, before finally outputting Verilog code, which can be simulated using a Verilog simulator, such as verilator. 
  
Finally there's Functional Coverage, which is a coverage metric based around evaluating the testing progress of specific features of a DUT. These are defined in what's called the Verification Plan. Functional coverage gives a qualitative measure of the testing progress, telling us "which features of the DUT have been tested?".

The specific type of fuzzing we use is called coverage driven mutation-based fuzzing. This is based around mutating a set of initial inputs, called seeds, depending on the coverage result they obtain after feeding them to the DUT. Mutated inputs that generate a higher coverage percentage are added to the seeds as "interesting inputs", and are then used as a basis for furthur mutation. The figure gives an overview of the fuzzing loop.  
  
## Current Solutions  
Now that we've presented the necessary background, let's briefly describe existing solutions for fuzzing digital designs.  
The first is called American Fuzzy Lop (AFL) and is a common software-specific fuzzer. AFL uses edge coverage as a driving metric and introduces mutation techniques which are efficient and often lead to "interesting" results. AFL is often used as a basis for other fuzzers and its mutation techniques are what we use in our solution.  
After that we have RFuzz, which is a fuzzer for RTL circuits. This solution leverages FPGAs to accelerate their fuzzer, they also employ techniques for fast and deterministic memory initialization. Rfuzz also relies on edge coverage as a drving metric.  
Finally, a completely different approach is used in Fuzzing Hardware like Software. Here they employ methods which translate a DUT into a software model which is then fuzzed using standard software fuzzers.  
All of these solutions rely on the same metric to guide fuzzing. We try to ask ourselves the following questions:   

- Why not use a more complex metric? 
- What will the performace impact look like?  

A potential answer would be to say that the performance impact would be too great, however, we think that the performance impact of using a complex metric can be recuperated by a faster converging fuzzer.  
  
## Our Solution  
This brings us to our solution, which is to create a fuzzer made specifically for chisel designs, which uses Fucntional Coverage as a driving metric.   
This fuzzer works in 5 phases:  

1. Interpret the input files as bit-streams and load them into a queue.  
2. Select the next file from the queue.  
3. Mutate the selected input.  
4. Run the test, the ouptuts of the test are then compared to a golden model's ouptut and if they match, we retrive coverage results otherwise we report the bug.  
5. Compare the coverage result with the previous ones, determine if the test was interesting and add it to the corups.  

### Defining a test

It's important to explain what we define as a test. The main difference with a software fuzzer's test is that here we need a way to define timing. This is done by stepping the clock between every input_sized segment in an input file. The input_size is the sum of all of the DUT's input's bit-lengths. So given a DUT with two 32 bit and one 64 bit input the input_size would be 128 bits. 

### Mutation Engine

Now let's talk about the mutation engine. A first attempt, was to directly use AFL's engine by interfacing into it using the Java Native Interface. However this increased the compilation time and added dependencies to the project, which we want to avoid. A solution to that was to reimplement a subset of AFL's mutation engine in Scala and adapt it to work well within our fuzzer. The mutation engine works by running a set of deterministic then non deterministic mutation passes. Currently we have only implemented deterministic passes, but are working on adding non-deterministic ones as well.  
  
## Initial Experiments  
We tested our implementation on the Leros Accumulator ALU. This has two inputs, one 3 bit operation and an 8 bit data input, as well as a 16 bit accumulated output. Our goal is to check every operation with the most interesting operands.  
To do this we need to   

1. Create a verification plan for the functional coverage,   
2. Create an input seed file and 
3. run the fuzzer with the preexisting golden model.    


The verification plan is defined using a set of cover constructs which tell us which ranges of values we want to expect for each operation. Functional coverage allows us to have both coarse and fine-grained coverage information about our test, which is beneficial for the input mutation. After the verification plan is defined, we define an input seed, here it simply computes 32 + 25. Finally we call the fuzzer by giving it the DUT, coverage reporter, golden model and then the output and seed file names.   
  
These initial tests have so far shown non-conclusive results, due to the fact that the fuzzer still only has deterministic mutation passes and thus can't really be compared to any other fuzzer yet. Work is being done on enabling the use of edge coverage on our fuzzer in order to compare it with the functional coverage counterpart. We expect that functional coverage will lead to a faster converging fuzzer, however the low effeciency of our Functional Coverage to still leaves a lot of room for improvement.  
  
## Conclusion  

The paper we presented is a sketch of how to support testing and verification of digital designs described in Chisel with fuzzing driven by a hardware-centric metric. It is also a basis for a more detailed performance evaluation when all mutation techniques are added. Current work is also being done in extending the fuzzing methods for constrained random code generation.  
  
Here are the references for the fuzzers I presented.  
This fuzzer is part of the chiselVerify project which you can find on github.

Thank you for listining and are there any questions?  


  
  
    