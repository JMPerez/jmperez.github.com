// {% codepen userId|anonymous|anon slugHash theme [defaultTab [height [width]]] %}
function codepenTagRender(args) {
    const userId = args[0] === 'anonymous' ? 'anon' : args[0];
    const slugHash = args[1];
    const theme = args[2];
    const defaultTab = args[3] != null ? args[3] : 'result';
    const height = args[4] != null ? args[4] : 300;
    const width = args[5] != null ? args[5] : '100%';
    const clickToLoad = args[6] != null ? args[6] : null;
    const src = `//codepen.io/${userId}/embed/${clickToLoad ? 'preview/' : ''}${slugHash}?height=${height}&theme-id=${theme}&slug-hash=${slugHash}&default-tab=${defaultTab}`;
    const id = `cp_embed_${slugHash.replace(/\//g, '_')}`

    return `<iframe id="${id}" src="${src}" scrolling="no" frameborder="no" height="${height}" allowTransparency="true" allowfullscreen="true" class="cp_embed_iframe" style="width: ${width}; overflow: hidden;"></iframe>`;
  }

  hexo.extend.tag.register('codepen', codepenTagRender);