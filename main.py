import csv
import os
import subprocess

from generate_sdc import generate_sdc
from generate_genus_tcl import generate_genus_tcl


BASE_DIR = "/home/userdata/22bec0985/GenusHelper"

RTL_CSV = os.path.join(BASE_DIR, "inputs", "rtl_variants.csv")
TIMING_CSV = os.path.join(BASE_DIR, "inputs", "timing_config.csv")

RUNS_DIR = os.path.join(BASE_DIR, "runs")
OUTPUTS_DIR = os.path.join(BASE_DIR, "outputs")

LIB_PATH = "/home/userdata/22bec0985/llm_project/baseline_designs/tcbn65gpluswcz_ccs.lib"

RUN_GENUS = True


def read_csv(path):
    with open(path, "r") as f:
        return list(csv.DictReader(f))


def main():
    rtl_variants = read_csv(RTL_CSV)
    timing_cases = read_csv(TIMING_CSV)

    os.makedirs(RUNS_DIR, exist_ok=True)
    os.makedirs(OUTPUTS_DIR, exist_ok=True)

    total_runs = 0

    for rtl in rtl_variants:
        for timing in timing_cases:
            variant_name = rtl["variant_name"]
            case_name = timing["case_name"]

            run_name = f"{variant_name}_{case_name}"
            run_dir = os.path.join(RUNS_DIR, run_name)
            os.makedirs(run_dir, exist_ok=True)

            sdc_path = os.path.join(run_dir, "constraints.sdc")
            tcl_path = os.path.join(run_dir, "run_genus.tcl")

            generate_sdc(
                clock_port=rtl["clock_port"],
                frequency_mhz=timing["frequency_mhz"],
                setup_uncertainty=timing["setup_uncertainty_ns"],
                hold_uncertainty=timing["hold_uncertainty_ns"],
                source_latency_max=timing["source_latency_max_ns"],
                source_latency_min=timing["source_latency_min_ns"],
                sdc_path=sdc_path
            )

            generate_genus_tcl(
                rtl_path=rtl["rtl_path"],
                top_module=rtl["top_module"],
                lib_path=LIB_PATH,
                sdc_path=sdc_path,
                run_dir=run_dir,
                tcl_path=tcl_path
            )

            print(f"[CREATED] {run_name}")
            print(f"   SDC : {sdc_path}")
            print(f"   TCL : {tcl_path}")

            if RUN_GENUS:
                print(f"[RUNNING GENUS] {run_name}")

                log_path = os.path.join(run_dir, "genus.log")

                with open(log_path, "w") as log_file:
                    subprocess.run(
                        'csh -i -c "suite; genus -f run_genus.tcl"',
                        cwd=run_dir,
                        stdout=log_file,
                        stderr=subprocess.STDOUT,
                        shell=True
                    )

            total_runs += 1

    print("\nDone.")
    print(f"Total runs prepared: {total_runs}")
    print("Genus execution is controlled by RUN_GENUS.")
    print("Next: run parse_and_analyze.py, then dashboard.py from outputs.")


if __name__ == "__main__":
    main()
