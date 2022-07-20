declare const Elm: ElmInstance;

document.addEventListener('DOMContentLoaded', async () => {
  Elm.Main.init({
    node: document.getElementById('application')!,
    flags: {
      bar: await Ext.getBookmarkBar(),
      others: await Ext.getOtherBookmarks(),
    },
  });
});
