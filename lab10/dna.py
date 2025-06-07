def read_dna(dna_file):
    """
    Read DNA pairs from a file and return them as a list of tuples.
    """
    pairs = []
    with open(dna_file, 'r') as file:
        for line in file:
            # Split the line by '<->' to get left and right bases
            parts = line.strip().split('<->')
            
            # Extract left and right bases, strip whitespace, and add to pairs list
            left_base = parts[0].strip() if parts[0].strip() else ''
            right_base = parts[1].strip() if parts[1].strip() else ''
            pairs.append((left_base, right_base))
    return pairs


def is_rna(dna_pairs):
    """
    Determine if the DNA pairs represent DNA, RNA, or an Invalid sequence.
    """
    count = {'A': 0, 'T': 0, 'G': 0, 'C': 0, 'U': 0}
    total_bases = 0

    # Count the occurrences of each base and total bases
    for left_base, right_base in dna_pairs:
        if left_base in count:
            count[left_base] += 1
            total_bases += 1
        if right_base in count:
            count[right_base] += 1
            total_bases += 1

    # Calculate the percentage of each base type
    dna_bases = count['A'] + count['T'] + count['G'] + count['C']
    rna_bases = count['A'] + count['U'] + count['G'] + count['C']

    # Determine the sequence type based on the percentage
    if dna_bases / total_bases >= 0.9:
        return "DNA"
    elif rna_bases / total_bases >= 0.9:
        return "RNA"
    else:
        return "Invalid"


def clean_dna(dna_pairs):
    """
    Clean the DNA pairs by filling in missing bases and removing invalid pairs.
    """
    sequence_type = is_rna(dna_pairs)
    
    # Define base pair maps for DNA and RNA
    dna_pair_map = {'A': 'T', 'T': 'A', 'G': 'C', 'C': 'G'}
    rna_pair_map = {'A': 'U', 'U': 'A', 'G': 'C', 'C': 'G'}
    pair_map = dna_pair_map if sequence_type == "DNA" else rna_pair_map

    clean_pairs = []
    
    # Iterate over DNA pairs and clean them
    for left_base, right_base in dna_pairs:
        if left_base == '' and right_base in pair_map:
            left_base = pair_map[right_base]
        elif right_base == '' and left_base in pair_map:
            right_base = pair_map[left_base]
        if left_base in pair_map and right_base in pair_map[left_base]:
            clean_pairs.append((left_base, right_base))
        elif right_base in pair_map and left_base in pair_map[right_base]:
            clean_pairs.append((left_base, right_base))

    return clean_pairs


def mast_common_base(dna_pairs):
    """
    Find the most common first base in the DNA pairs.
    """
    base_count = {}
    
    # Count occurrences of each base
    for left_base, _ in dna_pairs:
        if left_base:
            base_count[left_base] = base_count.get(left_base, 0) + 1

    # Find the most common base
    most_common_base = max(base_count, key=base_count.get)

    return most_common_base


def base_to_name(base):
    """
    Convert a base to its full name.
    """
    base_names = {
        'A': 'Adenine',
        'T': 'Thymine',
        'G': 'Guanine',
        'C': 'Cytosine',
        'U': 'Uracil'
    }
    
    return base_names.get(base, 'Unknown')
