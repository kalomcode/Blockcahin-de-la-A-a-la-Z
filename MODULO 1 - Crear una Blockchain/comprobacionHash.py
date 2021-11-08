import hashlib
new_proof = 45293
previous_proof = 533
hash_operation = hashlib.sha256(str(new_proof**2 - previous_proof**2).encode()).hexdigest()
print(hash_operation)