import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["team", "normal", "special"]

  connect() {
    this.colors = ["blue", "green", "yellow", "red", "gold", "platinum", "black"];
    this.cards = {};
    this.usedCards = {};

    // 各色のカードを初期化（仮のデータ）
    this.colors.forEach(color => {
      this.cards[color] = [`${color}-1`, `${color}-2`, `${color}-3`];
      this.usedCards[color] = [];
    });

    this.updateTeamOptions();
  }

  updateOptions() {
    this.normalTargets.forEach((normal, i) => {
      const special = this.specialTargets[i];
      const normalValue = normal.value;
      const specialValue = special.value;

      if (specialValue === "23") {
        normal.querySelectorAll("option").forEach(opt => {
          if (["11", "12", "13", "14"].includes(opt.value)) {
            opt.disabled = true;
          }
        });
      } else {
        normal.querySelectorAll("option").forEach(opt => opt.disabled = false);
      }

      if (["11", "12", "13", "14"].includes(normalValue)) {
        special.querySelectorAll("option").forEach(opt => {
          if (opt.value === "23") {
            opt.disabled = true;
            if (special.value === "23") special.value = "20";
          }
        });
      } else {
        special.querySelectorAll("option").forEach(opt => opt.disabled = false);
      }
    });
  }

  updateTeamOptions() {
    const selectedValues = this.teamTargets.map(select => select.value);

    this.teamTargets.forEach((select, i) => {
      const currentValue = select.value;
      Array.from(select.options).forEach(option => {
        option.disabled = (option.value !== currentValue && selectedValues.includes(option.value));
      });
    });
  }

  draw() {
    for (let i = 0; i < 4; i++) {
      const team = this.teamTargets[i].value;
      const normal = this.normalTargets[i].value;
      const special = this.specialTargets[i].value;

      let result = `${team} のカード結果：`;

      if (normal == 11) result += ` ブルー: ${this.drawCard("blue")} `;
      else if (normal == 12) result += ` グリーン: ${this.drawCard("green")} `;
      else if (normal == 13) result += ` イエロー: ${this.drawCard("yellow")} `;
      else if (normal == 14) result += ` レッド: ${this.drawCard("red")} `;

      if (special == 21) result += ` ゴールド: ${this.drawCard("gold")} `;
      else if (special == 22) result += ` プラチナ: ${this.drawCard("platinum")} `;
      else if (special == 23) result += ` ブラック: ${this.drawCard("black")} `;

      document.getElementById(`result${i}`).textContent = result;
    }

    document.getElementById("modal").style.display = "block";
  }

  drawCard(color) {
    if (this.cards[color].length === 0) {
      // 使用済みから再構成（リセット）
      this.cards[color] = [...this.usedCards[color]];
      this.usedCards[color] = [];
    }

    const index = Math.floor(Math.random() * this.cards[color].length);
    const card = this.cards[color][index];

    // 使用済み管理
    this.usedCards[color].push(card);
    this.cards[color].splice(index, 1);

    return card;
  }
}
