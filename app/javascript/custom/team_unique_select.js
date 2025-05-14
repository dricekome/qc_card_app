document.addEventListener("DOMContentLoaded", () => {
  const selects = document.querySelectorAll(".team-select");

  function updateOptions() {
    const selectedValues = Array.from(selects)
      .map(select => select.value)
      .filter(value => value !== "100"); // 100: 未選択扱い

    selects.forEach(select => {
      Array.from(select.options).forEach(option => {
        // 同じ値が既に他で使われてたら disabled、ただし自分の選択値は除外
        if (
          option.value !== "100" &&
          selectedValues.includes(option.value) &&
          select.value !== option.value
        ) {
          option.disabled = true;
        } else {
          option.disabled = false;
        }
      });
    });
  }

  // 初期化とイベント登録
  selects.forEach(select => {
    select.addEventListener("change", updateOptions);
  });

  updateOptions(); // 初期状態でも実行
});
