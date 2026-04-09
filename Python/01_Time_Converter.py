def convert_minutes(minutes):
    hrs = minutes // 60
    mins = minutes % 60

    if hrs and mins:
        return f"{hrs} hr{'s' if hrs>1 else ''} {mins} minutes"
    elif hrs:
        return f"{hrs} hr{'s' if hrs>1 else ''}"
    else:
        return f"{mins} minutes"

print(convert_minutes(130))
