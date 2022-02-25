import numpy as np
from pprint import pprint

a = np.array([
	[0, -2, 1],
	[-2, 0, 1],
	[0, -2, 1],
	[-2, 0, -1],
	[2, 0, -1],
	[2, 0, 1],
	[0, 2, 1],
	[0, 2, -1],
])

b = np.array([
	0, 0, 0, 0, 4, 4, 4, 4
])

solution_dict = {}

for i in range(len(a)):
	for j in range(len(a)):
		for k in range(len(a)):
			lst = [i, j, k]
			lst.sort()
			curr_combo = tuple(lst)
			if i != j and i != k and j != k and curr_combo not in solution_dict.keys():
				new_a = np.array([a[i], a[j], a[k]])
				new_b = np.array([b[i], b[j], b[k]])
				# solve the system to get the solution
				try:
					x = np.linalg.solve(new_a, new_b)
					solution_dict[curr_combo] = x
				except:
					solution_dict[curr_combo] = 0

saturated_constraints_dict = {}
for key, value in solution_dict.items():
	if not isinstance(value, int):
		for i in range(len(a)):
			if np.allclose(np.dot(a[i], value), b[i]):
				if key not in saturated_constraints_dict.keys():
					saturated_constraints_dict[key] = [f'C_{i+1}']
				else:
					saturated_constraints_dict[key].append(f'C_{i+1}')

print(saturated_constraints_dict)
