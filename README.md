<h1 align="center"> MIPS Pipeline Analysis <h1>

  <h2> Description: </h2>

  This is the first assignment for my [Computer Architecture Course](https://www.di.uoa.gr/en/studies/undergraduate/114) during my B.Sc in Informatics and Telecommunications.
  The purpose of this project is to study the performance of a [32-bit MIPS processor](https://en.wikipedia.org/wiki/MIPS_architecture) with several different setups and choose the implementation that is the best value for the cost.
  
  <h2> Developed with: </h2>
  
  * [QtMips DI](https://github.com/kchasialis/QtMips-Di)
  
  <h2> Detailed Description: </h2>
  
  Develop a MIPS program that calculates the [GCD](https://en.wikipedia.org/wiki/Greatest_common_divisor) and [LCM](https://en.wikipedia.org/wiki/Least_common_multiple) of three positive integers. This process will be applied in an array of 198 random numbers [1,99] which will be considered as consecutive pairs of 3. The results of each set must be then stored in 2 appropriate sized arrays. The array will be initialized in the program's memory and its content is not to be read or printed in the console, since we want to compare only the CPU times needed for each implementation. Find out which implementation brings the best value for the cost by testing your code.
  
  <h2> Constraints: </h2>
  
  | Parameter         | Extra Cost         | Clock overhead     |
  | :---------------: | :----------------: | :----------------: |
  | Ignore Data hazards                            | +0% | +0% |
  | Detect Data hazards and stall                  | +2% | +0% |
  | Detect Data hazards and forward                | +5% | +3% |
  | Ignore Control hazards and use Delay Slot      | +0% | +0% |
  | Detect Control hazards and stall               | +2% | +0% |
  | Use 1-bit Branch Predictor with 6-bit BHT       | +7% | +1% |
  | Use 2-bit Branch Predictor with 6-bit BHT       | +8% | +2% |
  | Use Branch resolution in ID stage instead of EX | +1% | +0% |
  
  <h2> Results: </h2>
  
  ***Let the base chip include at least the Data and the Control Hazard Unit at their simplest form to be considered a viable implementation. Let C be the chip cost and T the period of its clock. With these assumptions we conclude to the following:***
  
  |                 | CPU 0    | CPU 1    | CPU 2    | CPU 3    | CPU 4    | CPU 5    | CPU 6    | CPU 7    | CPU 8    |
  | :-------------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: | :------: |
  | CPU cost        | 104C     | 105C     | 108C     | 103C     | 110C     | 111C     | 106C     | 113C     | 114C     |
  | CPU clock       | 1T       | 1T       | 1,03T    | 1T       | 1,01T    | 1,02T    | 1,03T    | 1,04T    | 1,05T    |
  | Instructions    | ~13.400  | ~13.400  | ~13.400  | ~13.400  | ~13.400  | ~13.400  | ~16.300  | ~13.400  | ~13.400  |
  | Total Cycles    | ~19.400  | ~18.500  | ~16.300  | ~18.500  | ~16.850  | ~16.650  | ~16.300  | ~14.200  | ~14.000  |
  | CPI             | ~1,44869 | ~1,37973 | ~1,21658 | ~1,1341  | ~1,25711 | ~1,24240 | 1        | ~1,05955 | ~1,04485 |
  | Total Time      | ~19.400T | ~18.500T | ~16.800Τ | ~18.500T | ~17.000T | ~16.985T | ~16.795T | ~14.770T | ~14.700T |
  | Value for Money | 4,953    | 5,151    | 5,514    | 5,251    | 5,343    | 5,305    | 5,618    | 5,933    | 5,967    |
    
  <strong>Best Implementation: ***CPU 7***</strong>
  
  - [ ] Ignore Data hazards
  - [X] Detect Data hazards and stall
  - [ ] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [X] Detect Control hazards and stall
  - [X] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [ ] Use Branch resolution in ID stage instead of EX
  
  Tested Implementation Details:
  
  * CPU 0
  - [ ] Ignore Data hazards
  - [X] Detect Data hazards and stall
  - [ ] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [X] Detect Control hazards and stall
  - [ ] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 1
  - [ ] Ignore Data hazards
  - [ ] Detect Data hazards and stall
  - [X] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [X] Detect Control hazards and stall
  - [ ] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 2
  - [ ] Ignore Data hazards
  - [ ] Detect Data hazards and stall
  - [X] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [ ] Detect Control hazards and stall
  - [X] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 3
  - [ ] Ignore Data hazards
  - [X] Detect Data hazards and stall
  - [ ] Detect Data hazards and forward
  - [X] Ignore Control hazards and use Delay Slot
  - [ ] Detect Control hazards and stall
  - [ ] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 4
  - [ ] Ignore Data hazards
  - [X] Detect Data hazards and stall
  - [ ] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [ ] Detect Control hazards and stall
  - [X] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 5
  - [ ] Ignore Data hazards
  - [X] Detect Data hazards and stall
  - [ ] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [ ] Detect Control hazards and stall
  - [ ] Use 1-bit Branch Predictor with 6-bit BHT
  - [X] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 6
  - [ ] Ignore Data hazards
  - [ ] Detect Data hazards and stall
  - [X] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [X] Detect Control hazards and stall
  - [ ] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 7
  - [ ] Ignore Data hazards
  - [ ] Detect Data hazards and stall
  - [X] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [ ] Detect Control hazards and stall
  - [X] Use 1-bit Branch Predictor with 6-bit BHT
  - [ ] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX

  * CPU 8
  - [ ] Ignore Data hazards
  - [ ] Detect Data hazards and stall
  - [X] Detect Data hazards and forward
  - [ ] Ignore Control hazards and use Delay Slot
  - [ ] Detect Control hazards and stall
  - [ ] Use 1-bit Branch Predictor with 6-bit BHT
  - [X] Use 2-bit Branch Predictor with 6-bit BHT
  - [X] Use Branch resolution in ID stage instead of EX 

  <h2> Comments: </h2>
  
  Although CPU 8 won in terms of speed and cycle-efficiency, it turned out that CPU7 has the best value ratio overall, even by a slight margin. You can see the complete set of tests we ran in [ImplementationStatistics.xlsx](https://github.com/john-fotis/MIPS-Pipeline-Analysis/blob/main/Implementation%20Statistics.xlsx). The results came out from [these Datasets](https://github.com/john-fotis/MIPS-Pipeline-Analysis/tree/main/Datasets). You can try them out by simply pasting theme in $arr1 of [ca-II-handout-1.s](https://github.com/john-fotis/MIPS-Pipeline-Analysis/blob/main/ca-II-handout-1.s) or generate your own sets.
  
  <h2> Contributors: </h2>
  
  [katerinagiann](https://github.com/katerinagiann)
  
  <h2> License: </h2>
  
  This project is licensed under the [MIT License](https://github.com/john-fotis/MIPS-Pipeline-Analysis/blob/main/LICENSE.md)
