
The title is "Hardware as a Service".

The project addresses the following: (1) how to make hardware accelerates in the cloud accessible for SW developers, (2) how HW verification can learn from SW testing, and (3) co-verification of SW and HW with modern tooling. The project requests funding for two PhD students and is together with ITU.

 * Lead: Martin Schoeberl (DTU), Zhoulai Fu (ITU), Peter Sestoft <sestoft@itu.dk>
 * WS6, WS7
 * Core partners: DTU, ITU
 * External partners: TBD, invitation email is sent out


## Note:

 * There is some good text on co-verification in the ftp-chisel folder (in GitHub) as a Word document from ?
 * Accelerators are needed for AI and krypto stuff

### Verification Notes:

Verification of Hybrid Systems Consisting of Both Complex Digital Hardware and Software

Background

The mixture of tight time-to-market constraints and an increasing design complexity associated with the design and development of hybrid systems consisting of both digital hardware and software of today, implies that an efficient verification and qualification methodology is ever more important. 
A flexible verification methodology which combines different verification and qualification methods in the most optimal way, to keep the verification and qualification cycle as short as possible while maximizing the number of issues found are key to a successful project delivery.
Verification and qualification methodologies used today, most often rely on automated regression runs and focuses highly on randomized stimuli generation. Long running regressions benefit from being executed at system level using hardware emulated systems in the lab (e.g. using FPGAs and software running on actual processors). While this approach brings the benefit of execution speed allowing a broader verification coverage, the cost of this is limited visibility during debugging of failing regressions. Verification at register-transfer-level (RTL level) on the other-hand provides high visibility into the digital system but suffers from the challenge of very low cycle speed.
Consequently, it is desirable to catch as many issues as possible during RTL development as they are hard to debug in the lab, however, the simulation speed often becomes a challenge which does not allow for verification of complete initialization sequences which may include booting of operating systems etc. hence forcing one to verify larger parts of the system at system level in the lab with reduced visibility into the system as a cost.

Purpose

The purpose of the presented project is to obtain methods and tools that will allow increased visibility when debugging hybrid systems consisting of both hardware and software elements.

Description

The idea is to start the development of a framework, which will consist of both methods and tools which will allow failing regressions found as part of system level verification and qualification in the lab to be moved back into a simulation environment in which the visibility into the system can be increased for better debugging.
Ideally, the same verification framework used for system level verification in the lab can be reused in simulation to allow a sub-set of the found failing regressions to be re-executed in simulation with full visibility into the system.
One idea is to establish a co-simulation framework which would allow test-cases currently executing in a Napatech proprietary test framework used for system qualification in the lab to also be executed in the co-simulation framework. The co-simulation framework could be based on QEMU for software emulation combined with RTL simulators for emulation/simulation of the digital hardware entities.
Several challenges of this approach must be addressed, e.g. regarding the ability to speed up parts of the system (e.g. in a fast-forward mode), the ability to transfer the state of the system from the emulated hardware setup in the lab into the simulation environment and vice versa and in general to tackle the notion of time and synchronization between the different modules being simulated.
It is important that the methods and framework developed can be used in a UVM based verification methodology. It would also be relevant to investigate the use of the portable stimuli specification in this context.



## The Word template:

Title

Hardware as a Service

Short summary (3-5 lines)


Digital systems are a central part of our current and future digital enhanced live. Denmark has a considerable industry in the design and development of digital systems. However, designing and verifying such digital systems becomes an ever-growing challenge. The project addresses the following: (1) how to make hardware accelerates in the cloud accessible for software developers, (2) how hardware verification can learn from software testing, and (3) co-verification of software and hardware with modern tooling. The project requests funding for two PhD students at DTU and ITU. The project partners are Danish companies in the digital design domain.

**** following not in use ****
 The main issue is the usage of old tools compared to tools for programming those devices. This project aims to apply tools and methods from software development to hardware development to increase productivity. Danish firms will benefit from the results of this project.



Project type (Bridge/SciTech)


Bridge


Project period (Expected start date and length of project)


9/2021 4 years

Participants & collaborators
List potential partners and indicate whether there is a commitment from each partner. Please also indicate which workstreams are involved in the project.


DTU: Martin Schoeberl and Jan Madsen
ITU: Zhoulai Fu and Peter Sestoft

The topic is relevant to several companies in Denmark. Following companies provided an initial commitment: Napatech (Jesper Birch), GNResound (Drazen Horvat), Comcores (Thomas Noergaard, Joergen Carstensen), Teledyne Reson (Morten Rytter, Simon Andersen), WSAudiology (Ketil Julsgaard), and Microchip (Thomas Aakjer)

Following companies are considered additional partners: SyoSil (Jacob Sander Andersen), Synopsis (Martine Chegaray), and Demant (Anders Hebsgaard).

WS 6 and WS 7

Contact details
Name and contact details for the project proposer

Martin Schoeberl
Associate Professor

DTU Compute
Department of Applied Mathematics and Computer Science
Technical University of Denmark
Richard Petersens Plads
Building 322, room 128
2800 Lyngby
Denmark

Phone +45 50621247
Email masca@dtu.dk




 
Unmet needs (up to a page) 
What are the needs the project is addressing?

We can no longer depend on Moore's Law to increase computing performance. Performance increase with general-purpose processors has come to a halt. The only way to achieve higher performance or lower energy consumption is by building domain-specific hardware accelerators, e.g., for machine learning, networking, or cryptography. These accelerators can be built in chips or in FPGAs in the cloud. 

Until a few years, the two main design languages Verilog and VHDL dominated the design and testing of digital circuits. However, compared to software development and testing, digital design and testing methods and tools lack several decades of development. Within this project, we plan to leverage software development and testing methods for digital design. This shall also enable that software developers can program the FPGAs in the cloud.

The mixture of tight time-to-market constraints and an increasing design complexity associated with the design and development of hybrid systems consisting of both digital hardware and software of today, implies that an efficient verification and qualification methodology is ever more important. 
A flexible verification methodology which combines different verification and qualification methods in the most optimal way, to keep the verification and qualification cycle as short as possible while maximizing the number of issues found are key to a successful project delivery.

Verification and qualification methodologies used today, most often rely on automated regression runs and focuses highly on randomized stimuli generation. Long running regressions benefit from being executed at system level using hardware emulated systems in the lab (e.g. using FPGAs and software running on actual processors). While this approach brings the benefit of execution speed allowing a broader verification coverage, the cost of this is limited visibility during debugging of failing regressions. Verification at register-transfer-level (RTL level) on the other-hand provides high visibility into the digital system but suffers from the challenge of very low cycle speed.

Consequently, it is desirable to catch as many issues as possible during RTL development as they are hard to debug in the lab, however, the simulation speed often becomes a challenge which does not allow for verification of complete initialization sequences which may include booting of operating systems etc. hence forcing one to verify larger parts of the system at system level in the lab with reduced visibility into the system as a cost.



Research problems and aims (up to a page)
What are the research problems the project is addressing, what are the aims of the project and how will the project achieve these goals?


To efficiently develop and verify those accelerators, we can learn from software development trends such as agile software development. We believe that we need to adapt to agile hardware development.
Furthermore, as accelerators become part of the cloud service, i.e., FPGAs in the cloud, software developers will increasingly need to adapt critical algorithms to FPGAs to enhance performance. Hence, it is imperative to make accelerator design accessible for software developers. By adapting hardware accelerator design to the methods and tools of contemporary software design, it is possible to bridge both domains catering for a more uniform hardware/software development process.


This project explores the hardware construction language Chisel with Scala and the Universal Verification Method (UVM) with SystemVerilog for the design and test of digital systems. This project aims to develop a method and concrete tools for agile hardware development. We will use tools, languages, development, and testing methods from the last decades in software development and apply them to hardware design. We aim to raise the tooling level for a digital design to increase productivity.
Time for verifying (testing) of digital systems is about double the time of developing them in the first place. Therefore, this project's central focus is on applying software testing methods for hardware testing.
We will build a combination of open-source tools for verifying circuits described in mixed languages (VHDL, SystemVerilog, and Chisel). It builds on top of the Chisel hardware construction language and uses Scala to drive the verification. We will explore the testing strategy used in UVM in the context of verifying hardware described in Chisel.

%This project proposes a research project that aims at building a testing framework
%in Scala that takes the best methods from UVM and from decades of experience
%in software testing.
%The developed framework shall support mixed languages (VHDL, SystemVerilog, and Chisel)
%to be able to integrate legacy code.
%Furthermore, our aim is to build on open-source projects. Therefore, our
%work will be in open-source as well.

The idea is to start the development of a framework, which will consist of both methods and tools which will allow failing regressions found as part of system level verification and qualification in the lab to be moved back into a simulation environment in which the visibility into the system can be increased for better debugging. Ideally, the same verification framework used for system level verification in the lab can be reused in simulation to allow a sub-set of the found failing regressions to be re-executed in simulation with full visibility into the system.

One idea is to establish a co-simulation framework which would allow test-cases currently executing in a Napatech proprietary test framework used for system qualification in the lab to also be executed in the co-simulation framework. The co-simulation framework could be based on QEMU for software emulation combined with RTL simulators for emulation/simulation of the digital hardware entities. Several challenges of this approach must be addressed, e.g. regarding the ability to speed up parts of the system (e.g. in a fast-forward mode), the ability to transfer the state of the system from the emulated hardware setup in the lab into the simulation environment and vice versa and in general to tackle the notion of time and synchronization between the different modules being simulated. It is important that the methods and framework developed can be used in a UVM based verification methodology. It would also be relevant to investigate the use of the portable stimuli specification in this context.

A grand hardware verification objective would be to verify the functional correctness of all realistic run-time scenarios. To this end, code coverage metrics, in combination with software simulation, remain to be an essential way in quantifying verification completeness and identifying inadequately exercised design aspects. The challenge, however, lies in *how to achieve high cove coverage automatically*.

We propose to apply state-of-the-art software techniques, *coverage-driven fuzzing*, to address this challenge. The approach comes from the field of software testing, which has allowed for the detection of a large number of safety and security bugs, e.g. over 25,000 bugs in 375 open-source projects in Google's Continuous Fuzzing initiative. The high-level idea of coverage-based fuzzing techniques is as follows: (1) We will start with feeding random stimuli or user-provided input corpus to trigger an initial set of executions in simulation. (2) Coverage-based fuzzing tools then provide a feedback engine to smartly and selectively choose "interesting" testing inputs. Interesting ones are those that improve code coverage from previous executions. For implementation, we plan to write a coverage-based fuzzer our hardware modeling languages. (Our ITU partner Zhoulai Fu has had extensive experiences in fuzzing techniques and developing related tools in the research of testing, software analysis. and formal verification). 




Value Creation (up to a page)
Value creation: scientific value, capacity building, business, and societal value. How is the project creating value, for whom and why is it important right now? 

Digital technologies are currently the main driver for growth in Denmark. Furthermore, the Covid-19 induced working from home, gives a further boost to digitalization right now.

This project with the cooperation between researchers as DTU and ITU and Danish companies will allow Denmark to take the lead in digital research and development.

Two PhD students, and additional master students, will become highly educated engineers, who are in need in Danish industry in digital systems design. Those students will also learn how to program the accelerators in the cloud for future applications 


At DTU and ITU we will advance the research in the design and test of digital systems. This research will drive the adaption of the education curriculum towards modern tools and methods.

The industrial project partners will learn and get exposed to modern tools and methods to increase the efficiency of designing and testing digital systems.

The partner companies, who design hardware, can benefit from our developed software tool that generates test stimuli achieving high coverage of the hardware in simulation.

<!---Value creation from Zhoulai(ITU) starts--->

- This work will pave the way to an automated hardware testing approach.

- Users who design hardware using UVM can benefit from a software tool that generates test stimuli achieving high coverage of the hardware in simulation. The tool can find hardware defects and provide additional reliability thanks to comprehensive test coverage.

- The implementation and experiments from this work will likely promote UVM as a hardware design language with powerful software testing support.

<!---Value creation from Zhoulai(ITU) end--->


Budget (use the Excel sheet)
Estimate of overall budget distribute on the partners and estimate of co-financing



