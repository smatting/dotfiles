#!/usr/bin/env python3

import pathlib
import os
import textwrap
from dataclasses import dataclass


mydir = pathlib.Path(__file__).parent.resolve()
rule_idx = 1

attrs_critical = {'urgency':  "critical"}
attrs_normal = {'urgency':  "normal"}
attrs_ignore = {"skip_display": "true"}
attrs_attention = {'background':  "#7b5a78", "frame_color": "#333333", "foreground": "#ffffff", "skip_display": "false"}


def wire(rule):
    if rule.get('body') is None:
        rule['body'] = ''
    rule['body'] = '.*(wire.com|wire.link).*' + rule['body']
    return rule

def fpath(fname):
    return os.path.join(mydir, fname)

@dataclass
class Rule:
    name: str
    attrs: dict

def read_file(path):
    with open(path, 'r') as f:
        return f.read()

def write_file(path, s):
    with open(path, 'w') as f:
        f.write(s)

def render_rule(rule):
    head = '[{}]'.format(rule.name)
    xs = []
    for k, v in rule.attrs.items():
        xs.append('{} = "{}"'.format(str(k), str(v)))
    body = textwrap.indent('\n'.join(xs), '    ')
    return '{}\n{}\n\n'.format(head, body)

def render_rules(rules):
    return ''.join([render_rule(r) for r in rules])

def new_rule_name():
    global rule_idx
    s = 'rule_{}'.format(rule_idx)
    rule_idx = rule_idx + 1
    return s

def new_rule(match_attrs, apply_attrs):
    d = {}
    d.update(match_attrs)
    d.update(apply_attrs)
    return Rule(new_rule_name(), d)

def j(dicts):
    result = {}
    for d in dicts:
        result.update(d)
    return result

def tag_rules():
    return [
        new_rule(j([wire({})]), attrs_critical),
        new_rule(j([wire({'summary': ' in '})]), attrs_normal),
        new_rule({'summary': 'pomo'}, attrs_critical),
        new_rule(j([wire({'body': '[Mm]ention:'})]), attrs_critical),
        new_rule(j([wire({'body': 'Reply:'})]), attrs_critical),
        new_rule(j([wire({'body': 'Calling'})]), attrs_critical),
        new_rule(j([wire({'body': 'backend'})]), attrs_critical)
    ]

def write_config_rules(path, rules):
    base = read_file(fpath('dunstrc_base'))
    rules_rendered = render_rules(rules)
    hline = "{}\n".format("".join(["#"] * 80))
    write_file(path, '\n\n'.join([base, hline, rules_rendered]))

def main():
    profiles = {
        'quiet':
            [new_rule({}, attrs_ignore)]
            + tag_rules()
            + [new_rule({'msg_urgency': 'critical'}, attrs_attention)],
        'presentation': [new_rule(wire({}), attrs_ignore)]
    }
    for name, rules in profiles.items():
        write_config_rules(fpath(f'dunstrc_{name}'), rules)

    write_config_rules(fpath(f'dunstrc'), tag_rules() + [new_rule({'msg_urgency': 'critical'}, attrs_attention)])

if __name__ == '__main__':
    main()
