import csv
import random
import os
import sys

NUM_ROWS = 67
COLUMNS = ["Kind", "Number_of_eyes", "Height", "Works_for_Gru"]

def generate_row():

    return {
        "Kind": random.choice(["ordinary", "mutated"]),
        "Number_of_eyes": random.randint(1, 2),
        "Height": round(random.uniform(94, 120), 2),
        "Works_for_Gru": random.choice(["yes", "no"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)
