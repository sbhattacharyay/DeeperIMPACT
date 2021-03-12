def multi_to_ord(y):
    no_classes = len(y.unique())
    sorted_vals = np.sort(y.unique())
    ordinal_labels = np.full((len(y), no_classes-1), np.nan)
    for m in range(ordinal_labels.shape[1]):
        ordinal_labels[:,m] = (y > sorted_vals[m]).astype(int)
    return ordinal_labels

def ord_to_multi_probs(ord_probs):
    class_probs = np.full((ord_probs.shape[0],ord_probs.shape[1]+1),np.nan)
    class_probs[:,0] = 1 - ord_probs[:,0]
    class_probs[:,-1:] = ord_probs[:,-1:]
    for cp_idx in np.arange(1,class_probs.shape[1]-1):
        class_probs[:,cp_idx] = ord_probs[:,(cp_idx-1)] - ord_probs[:,cp_idx]
    return class_probs