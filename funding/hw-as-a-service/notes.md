
The title is "Hardware as a Service".

The project addresses the following: (1) how to make hardware accelerates in the cloud accessible for SW developers, (2) how HW verification can learn from SW testing, and (3) co-verification of SW and HW with modern tooling. The project requests funding for two PhD students and is together with ITU.

 * Lead: Martin Schoeberl (DTU), Zhoulai Fu (ITU)
 * WS6, WS7
 * Core partners: DTU, ITU
 * External partners: TBD, invitation email is sent out


## Note:

 * There is some good text on co-verification in the ftp-chisel folder as a Word document from ?
 * Accelerators are needed for AI and krypto stuff


## The Word template:

Title

Hardware as a Service

Short summary (3-5 lines)


The project addresses the following: (1) how to make hardware accelerates in the cloud accessible for SW developers, (2) how HW verification can learn from SW testing, and (3) co-verification of SW and HW with modern tooling. The project requests funding for two PhD students at DTU and ITU. The project partners are Danish companies in the digital design domain.


Project type (Bridge/SciTech)





Project period (Expected start date and length of project)




Participants & collaborators
List potential partners and indicate whether there is a commitment from each partner. Please also indicate which workstreams are involved in the project.





Contact details
Name and contact details for the project proposer

 
Unmet needs (up to a page) 
What are the needs the project is addressing?


Research problems and aims (up to a page)
What are the research problems the project is addressing, what are the aims of the project and how will the project achieve these goals?




<!---Research problems and aims from Zhoulai(ITU) starts--->

A grand hardware verification objective would be to verify the functional correctness of all realistic run-time scenarios. To this end, code coverage metrics, in combination with software simulation, remain to be an essential way in quantifying verification completeness and identifying inadequately exercised design aspects. The challenge, however, lies in *how to achieve high cove coverage automatically*.

We propose to apply state-of-the-art software techniques, *coverage-driven fuzzing*, to address this challenge. The approach comes from the field of software testing, which has allowed for the detection of a large number of safety and security bugs, e.g. over 25,000 bugs in 375 open-source projects in Google's Continuous Fuzzing initiative. The high-level idea of coverage-based fuzzing techniques is as follows: (1) We will start with feeding random stimuli or user-provided input corpus to trigger an initial set of executions in simulation. (2) Coverage-based fuzzing tools then provide a feedback engine to smartly and selectively choose "interesting" tesitng inputs. Interesting ones are those that improve code coverage from previous executions. For implementation, we plan to write a coverage-based fuzzer for UVM, our hardware modeling languages. (Our ITU partner Zhoulai Fu has had extensive experiences in fuzzing techniques and developing related tools in the research of testing, software analysis. and formal verification). 

<!---Research problems and aims from Zhoulai(ITU) ends--->




Value Creation (up to a page)
Value creation: scientific value, capacity building, business, and societal value. How is the project creating value, for whom and why is it important right now?  


<!---Value creation from Zhoulai(ITU) starts--->

- This work will pave the way to an automated hardware testing approach.

- Users who design hardware using UVM can benefit from a software tool that generates test stimuli achieving high coverage of the hardware in simulation. The tool can find hardware defects and provide additional reliability thanks to comprehensive test coverage.

- The implementation and experiments from this work will likely promote UVM as a hardware design language with powerful software testing support.

<!---Value creation from Zhoulai(ITU) end--->


Budget (use the Excel sheet)
Estimate of overall budget distribute on the partners and estimate of co-financing



