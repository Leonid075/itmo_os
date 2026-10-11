import numpy as np
import pandas as pd
from scipy import stats

CSV_PATH = "results_pilot.csv"
CONFIDENCE = 0.95
REL_E = 0.10

df = pd.read_csv(CSV_PATH)

rows = []
for mode, group in df.groupby("mode"):
    for metric in ["real", "user", "sys"]:
        sample = group[metric].to_numpy()
        mean = sample.mean()
        s = sample.std(ddof=1)
        e = max(REL_E * mean, 1e-9)

        n_est = (stats.norm.ppf(1 - (1 - CONFIDENCE) / 2) * s / e) ** 2
        for _ in range(50):
            deg_f = max(int(np.ceil(n_est)) - 1, 1)
            t = stats.t.ppf(1 - (1 - CONFIDENCE) / 2, df=deg_f)
            n_new = (t * s / e) ** 2
            if abs(n_new - n_est) < 0.01:
                n_est = n_new
                break
            n_est = n_new

        rows.append([mode, metric, round(mean, 4), round(s, 4), int(np.ceil(n_est))])

result = pd.DataFrame(rows, columns=["mode", "metric", "mean", "std", "N"])
print(result.to_string(index=False))
