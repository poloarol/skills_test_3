
# Answer Key - CERC Coding skill test

## System Requirements
- Ubuntu 18.04/22.04 or Debian 11

## Open-source Tools
- Python 3.8
- scikit-learn 1.3
- plotnine 0.12.3
- pandas 2.0.3
- numpy 1.24.4
- Snakemake 7.32.4

## Folder Description
- data
    - Input: Files provided for the challenge (*.cram, *.cram.crai, *.txt)
    - Output: Where files generated by the pipeline would be stored
    - model
        - Calibrated CV Random Forest model
        - Normalizer model
- reference: Reference genome (GRCh38) and its index
- VerifyBamID: Build version of VerifyBamID2
- example: Provided output of the coding challenge used for guidance
- pipeline:
    - config:
        - config.yaml
    - workflow:
        - notebooks: Jupyter Notebook for analysis and data wrangling
        - Snakefile: Snakemake pipeline logic
    - run_test.sh: Test to determine if the pipeline compiles
    - run.sh: Runs pipeline
- .gitignore
- environment.yml: Requirements files to reproduce conda environment
- ReadMe.md

## Setup working environment

- If you do not have Anaconda, please install it using the following directives: `https://linuxize.com/post/how-to-install-anaconda-on-ubuntu-20-04/`
- Then create a conda environment using the following command: `conda env create --file environment.yml`
- Activate the conda environment: `conda activate cerc-skill-test`

## Download reference files
- In the `\skills_test_3` folder, run the following command to download reference file: `bash download_references.sh`

## Download input data and models
- Download the `data.zip` (https://drive.google.com/file/d/1dLIizw-Z-m9xSgX6xHKNSLibfZTOB08Y/view?usp=sharing) folder and place it in the `\skills_test_3` directory, and the unzip it.

## Download and build VerifyBamID
Within the `/skills_test_3` directory:
    - clone the VerifyBamID repository: `git clone https://github.com/Griffan/VerifyBamID.git`
    - Do the following sequentially:
        ` cd VerifyBamID `
        ` mkdir build `
        ` cd build `
        ` cmake .. `
        ` make `
        ` make test `

## Update config file
- Update the `config.yaml` file within the `/pipeline/config` directory
    - `root`: Complete path to the `skill_test_3` directory
    - `num_threads`: Number of threads your computer can spare

## Run Pipeline
- To generate these files, run the following code in your conda environment: `bash run.sh <num_cpus>`, within the `/pipeline` folder.

## Challenge One

- For each of the input files, the pipeline produces a `.Ancestry` and `.selfSM` files.
- The results of each `.selfSM` file are aggregated to produce the `Contamination.txt`
- A temporary file `all_estimated_pcs.txt` is also created to store all PCs.

## Challenge Two

The pipeline first produces a file `data/output/all_estimated_pcs.txt`. This contains the sample ID, with its four associated PCs generated within the aggregated `.Ancestry` files.
A series of data wrangling steps are performed:
- Merging both reference files `${VERIFY_BAM_ID_HOME}/resource/1000g.phase3.100k.b38.vcf.gz.dat.V` and `input/1000G_reference_populations.txt` by the SAMPLE column. This allows us to maintain data integrity when associating each data point with the correct ancestry.
- Rearrange the data frame obtained from `data/output/all_estimated_pcs.txt`, to be in the format `SAMPLE, PC1, PC2, PC3, PC4` and setting the Ancestry to `Study`
- Combine both the reference and study data frames and make the series of required plots

## Challenge Three

- Merging both reference files `${VERIFY_BAM_ID_HOME}/resource/1000g.phase3.100k.b38.vcf.gz.dat.V` and `input/1000G_reference_populations.txt` by the SAMPLE column. This allows us to maintain data integrity when associating each data point with the correct ancestry.
- Use a Logistic Regression model to set a baseline. This allows to determine the level of poor performance we can accept, by determine classification performance i.e accuracy, balanced accuracy etc.
- Train a Random Forest Classifier to get better results, as tree based models outperform most models on tabular data. Determine classification performance.
- Perform hyperparameter tuning on the random forest classifier, using a grid search., and get the best model
- Train the best suggested model, and predict the ancestry of the study participants


## Calibrated CV Random Forest Model

- Steps to build a random forest classifier can be seen in the Jupyter notebook within the `/pipeline/workflow/notebooks` directory
- You will have to update the path to the files being used, by updating the root variable in the notebook: `/home/user/skills_test_3/`