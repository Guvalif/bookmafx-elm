declare const Elm: ElmInstance;

document.addEventListener('DOMContentLoaded', () => {
  Elm.Main.init({
    node: document.getElementById('application')!,
  });
});
