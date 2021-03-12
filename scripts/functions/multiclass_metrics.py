from sklearn.metrics import roc_auc_score

def recall_m(y_true, y_pred):
    true_positives = K.sum(K.round(K.clip(y_true * y_pred, 0, 1)))
    all_positives = K.sum(K.round(K.clip(y_true, 0, 1)))
    
    recall = true_positives / (all_positives + K.epsilon())
    return recall

def precision_m(y_true, y_pred):
    true_positives = K.sum(K.round(K.clip(y_true * y_pred, 0, 1)))
    predicted_positives = K.sum(K.round(K.clip(y_pred, 0, 1)))
    
    precision = true_positives / (predicted_positives + K.epsilon())
    return precision

def f1_score_m(y_true, y_pred):
    precision = precision_m(y_true, y_pred)
    recall = recall_m(y_true, y_pred)
    return 2*((precision*recall)/(precision+recall+K.epsilon()))

def multiclass_auc(y_true, y_pred):  
    return K.cast(roc_auc_score(y_true, y_pred, average='macro', multi_class='ovr'),dtype='float64')

def ordinal_auc(y_true, y_pred):  
    K.size(y_pred)
    
    pred_probs = K.concatenate([K.zeros_like(y_pred),K.zeros([K.shape(y_pred)[0],1])],1)
    
    mn_pred = ord_to_multi_probs(y_pred)
    mn_true = ord_to_multi_probs(y_true)
    
    class_probs = np.full((ord_probs.shape[0],ord_probs.shape[1]+1),np.nan)
    class_probs[:,0] = 1 - ord_probs[:,0]
    class_probs[:,-1:] = ord_probs[:,-1:]
    for cp_idx in np.arange(1,class_probs.shape[1]-1):
        class_probs[:,cp_idx] = ord_probs[:,(cp_idx-1)] - ord_probs[:,cp_idx]
    
    return K.cast(roc_auc_score(mn_true, mn_pred, average='macro', multi_class='ovr'),dtype='float64')