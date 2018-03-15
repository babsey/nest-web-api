
def stringify(data):
    if isinstance(data, list) or isinstance(data, tuple):
        data = [stringify(res) for res in data]
    elif isinstance(data, dict):
        for key in ['element_type', 'model', 'record_from', 'record_to', 'type_id']:
            if key not in data:
                continue
            if isinstance(data[key], tuple):
                data[key] = [d.name for d in data[key]]
            else:
                data[key] = data[key].name
        if 'recordables' in data:
            data['recordables'] = [
                recordable.name for recordable in data['recordables']]
        if 'events' in data:
            for key in data['events']:
                data['events'][key] = data['events'][key].tolist()
    return data
