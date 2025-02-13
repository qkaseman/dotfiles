# Tampermonkey

[Tampermonkey](https://www.tampermonkey.net/) is a browser extension that
allows writing custom JavaScript. It has essentially no utilities though, so
this is my repository of "snippets" essentially. Some are stupidly simple but
common enough I don't want to have to think about them.

## Sleep

```js
/**
 * Pause execution for input time.
 *
 * @param ms - milliseconds to sleep
 */
function sleep(ms){
  return new Promise(function (resolve) {
    setTimeout(()=>resolve(), ms)
  }
)}
```

## Mouse Events

```js
/**
 * Create and dispatch a mouse event to the input node.
 *
 * @param node - node to dispatch the event to
 * @param eventType - event type to create
 */
function triggerMouseEvent(node, eventType) {
  var clickEvent = document.createEvent('MouseEvents');
  clickEvent.initEvent(eventType, true, true);
  node.dispatchEvent(clickEvent);
}
```

## Simulate Typing

```js
/**
 * Simulate a user typing.
 *
 * @param e - element to "type" on
 * @param s - string to "type"
 */
async function simulateUserTyping(e, s) {
  const event = {
    focus: new Event('focus', { bubbles: true }),
    down: new Event('keydown', { bubbles: true }),
    up : new Event('keyup', { bubbles: true }),
    change: new Event('change', { bubbles: true }),
  }
  let value = e.value;

  e.focus();
  for (let ii = 0; ii < s.length; ii++) {
    await sleep((Math.floor(Math.random() * 50)) + 2);
    value += s.charAt(ii);
    e.value = value;
    e.dispatchEvent(event.focus);
    e.dispatchEvent(event.down);
    e.dispatchEvent(event.up);
    e.dispatchEvent(event.change);
  }
}
```

## Create Floating Button

> Note: Adding the styling requires `// @grant       GM_addStyle` in the
> frontmatter.

```js
/**
 * Create a floating button.
 *
 * Yes it looks atrocious. Yes that is the point.
 *
 * @param id - DOM id for the button
 * @param text - text for the button
 * @param onClick - event to trigger on click
 * @param cId - optional container ID, will be ${id}-container if omitted
 */
function createFAB(id, text, onClick, cId) {
  var containerId = cId ? cId : `${id}-container`;
  var n = document.createElement('div');
  n.innerHTML = `<button id="${id}" type="button">${text}</button>`;
  n.setAttribute('id', containerId);
  document.body.appendChild(n);

  document.getElementById(id).addEventListener(
      'click',
      onClick,
      false
  );

  const neonGreen = '#3EFF15';
  const neonPink = '#ff12f0';
  const neonPurple = '#be00fe'
  GM_addStyle(`
#${containerId} {
    position:   fixed;
    top:        0;
    left:       0;
    font-size:  20px;
    background: ${neonPink};
    border:     3px outset ${neonGreen};
    margin:     5px;
    opacity:    1.0;
    z-index:    9999;
    padding:    5px 20px;
}
#${id} {
    cursor:     pointer;
    background: ${neonPurple};
    color:      ${neonGreen}
}`.trim());
}
```
