'use strict';

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

test('selected idea chip is highlighted with a fill, not a heavy outline ring', () => {
  const css = fs.readFileSync(path.join(__dirname, '../public/styles.css'), 'utf8');
  const rule = css.match(/\.modal-idea-item\.selected\s*\{[^}]*\}/)[0];

  assert.doesNotMatch(rule, /box-shadow/, 'selected chip should not have an outline ring');
  assert.match(rule, /background:\s*var\(--accent\)/, 'selected chip should be filled with the accent color');
  assert.match(rule, /color:\s*#fff/, 'selected chip text should be white on the accent fill');
});
