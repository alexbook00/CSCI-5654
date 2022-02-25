import numpy as np
from pprint import pprint

A = np.array([
	[0, -2, 1],
	[-2, 0, 1],
	[0, -2, -1],
	[-2, 0, -1],
	[2, 0, -1],
	[2, 0, 1],
	[0, 2, 1],
	[0, 2, -1],
])

b = np.array([
	0, 0, 0, 0, 4, 4, 4, 4
])

for i in range(len(A)):
	for j in range(len(A)):
		for k in range(len(A)):
			lst = [i, j, k]
			lst.sort()
			curr_combo = tuple(lst)
			if i != j and i != k and j != k:
				new_A = A[[i, j, k]]
				new_b = b[[i, j, k]]
				# solve the system to get the solution
				try:
					candidate_vertex = np.linalg.solve(new_A, new_b)
				except:
					continue

				# check if candidate_solution satisfies all 8 constraints
				constraints_saturated = np.where(np.isclose(A @ candidate_vertex, b))[0] + 1
				if np.all(A @ candidate_vertex <= b) and len(constraints_saturated) > 2:
					print(f'########## \n Vertex: {candidate_vertex} \n Constraints Saturated: {constraints_saturated}')
