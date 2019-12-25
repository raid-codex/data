import json
import requests
import csv
import os
import sys

# The repository to add this issue to
REPO_OWNER = 'raid-codex'
REPO_NAME = 'data'


def make_github_issue(title, body=None, labels=None):
    '''Create an issue on github.com using the given parameters.'''
    # Our url to create issues via POST
    url = "https://api.github.com/repos/{}/{}/issues?access_token={}".format(
        REPO_OWNER,
        REPO_NAME,
        os.getenv("GITHUB_TOKEN"),
    )
    # Create an authenticated session to create the issue
    # Create our issue
    issue = {'title': title, 'body': body, 'labels': labels}
    # Add the issue to our repository
    r = requests.post(url, json=issue)
    try:
        r.raise_for_status()
    except Exception as e:
        print("Cannot create issue {}".format(issue))
        raise e


with open(sys.argv[1], 'r') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        body = "# {}\n\n".format(row['Name of the Champion'])
        for i in range(1, 5):
            body += "## Skill {}\n\n{}\n\n".format(i,
                                                   row['Skill {}'.format(i)])
        body += "## Aura\n\n{}\n\n".format(row['Aura'])
        make_github_issue(title="{} - {}".format(row['Timestamp'], row['Name of the Champion']),
                          body=body,
                          labels=['form-champions', 'bug'])
