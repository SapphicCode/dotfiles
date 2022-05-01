#!/opt/homebrew/bin/python3

import datetime
import subprocess
import json

# <xbar.title>Timewarrior</xbar.title>
# <xbar.author>Cassandra</xbar.author>
# <xbar.author.github>SapphicCode</xbar.author.github>

timew = "/opt/homebrew/bin/timew"

json_blob = subprocess.check_output(args=(timew, "export", "today"))
time_entries = json.loads(json_blob)

total_duration = datetime.timedelta()


def parse(timecode):
    """
    timecode = "20220426T062024Z"
    """
    year = timecode[0:4]
    month = timecode[4:6]
    day = timecode[6:8]
    hour = timecode[9:11]
    minute = timecode[11:13]
    second = timecode[13:15]
    return datetime.datetime.fromisoformat(
        f"{year}-{month}-{day}T{hour}:{minute}:{second}+00:00"
    )


for entry in time_entries:
    if not entry.get("end"):
        end = (
            datetime.datetime.utcnow()
            .isoformat(timespec="seconds")
            .replace("-", "")
            .replace(":", "")
            + "Z"
        )
    else:
        end = entry["end"]

    entry["duration"] = parse(end) - parse(entry["start"])
    total_duration += entry["duration"]

last_entry = (
    {"tags": ["Nothing"], "duration": datetime.timedelta(), "end": "foo"}
    if not time_entries
    else time_entries[-1]
)
running = not last_entry.get("end")

print(
    f"""
{':hourglass_flowing_sand:' if running else ':hourglass:'} {str(total_duration)[:-3]}
---
{'Current' if running else 'Last'} entry: {', '.join(last_entry['tags'])}
{last_entry['duration']}
{'Stop Timer | param1=stop' if running else 'Resume Timer | param1=continue'} shell={timew} refresh=true
---
Start Frequent Timers
-- Planning             | refresh=true shell={timew} param2=Planning
-- Development          | refresh=true shell={timew} param1=start param2=Development
-- Meetings             | refresh=true shell={timew} param1=start param2=Meetings
-- Meetings, Scrum      | refresh=true shell={timew} param1=start param2=Meetings param3=Scrum
-- Meetings, OKR        | refresh=true shell={timew} param1=start param2=Meetings param3=OKR
""".strip()
)
