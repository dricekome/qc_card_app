document.addEventListener("DOMContentLoaded", function () {
  const selects = document.querySelectorAll(".team-select");

  function updateOptions() {
    const selectedValues = Array.from(selects).map(select => select.value);

    selects.forEach(select => {
      const currentValue = select.value;

      Array.from(select.options).forEach(option => {
        if (option.value === "100") {
          option.disabled = false;
        } else {
          // 自分以外で同じ値が選ばれていたら無効に
          option.disabled = selectedValues.includes(option.value) && option.value !== currentValue;
        }
      });
    });
  }

  selects.forEach(select => {
    select.addEventListener("change", updateOptions);
  });

  updateOptions(); // 初期化
});
