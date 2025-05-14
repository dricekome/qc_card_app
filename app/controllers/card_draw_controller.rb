class CardDrawController < ApplicationController
  def index
  end

  def draw
    @results = []

    (1..4).each do |i|
      team = params["team#{i}"]
      normal_color = convert_color_key(params["normal#{i}"])
      special_color = convert_color_key(params["special#{i}"])

      cards = []

      # 通常カードの抽選
      if normal_color.present?
        card = QuestCard.where(color: normal_color, ussed: false).sample
        if card
          card.update(used: true)
          cards << "#{normal_color_jp(normal_color)}：#{card.name}"
        else
          reset_color(normal_color)
          retry_card = QuestCard.where(color: normal_color, used: false).sample
          retry_card&.update(used: true)
          cards << "#{normal_color_jp(normal_color)}：#{retry_card&.name || "カードが見つかりません"}"
        end
      end

      # スペシャルカードの抽選
      if special_color.present?
        if special_color == "black"
          cards << "ブラック：非公開カードです"
        else
          card = QuestCard.where(color: special_color, used: false).sample
          if card
            card.update(used: true)
            cards << "#{special_color_jp(special_color)}：#{card.name}"
          else
            reset_color(special_color)
            retry_card = QuestCard.where(color: special_color, used: false).sample
            retry_card&.update(used: true)
            cards << "#{special_color_jp(special_color)}：#{retry_card&.name || "カードが見つかりません"}"
          end
        end
      end

    def team_name(team_id)
      {
        "100" => "---",
        "101" => "compagno",
        "102" => "呑雲吐龍",
        "103" => "緑龍",
        "104" => "Wing Blaves",
        "105" => "Pursuing Fun!",
        "106" => "でるぽんみるちーず",
        "107" => "BITE into FATE",
        "108" => "Beiowolf",
        "109" => "SkyRoad",
        "110" => "RED ZONE!",
        "111" => "ローリエ",
        "112" => "Ne_oLion",
      }[team_id] || "不明なチーム"
    end
    @results << {
        team: team_name(team),
        cards: cards,
      }
    end

    render :result
  end

  # 補助：色名のキー変換（日本語→英語）
  def convert_color_key(jp)
    {
      "ブルー" => "blue",
      "グリーン" => "green",
      "イエロー" => "yellow",
      "レッド" => "red",
      "ゴールド" => "gold",
      "プラチナ" => "platinum",
      "ブラック" => "black",
    }[jp]
  end

  def normal_color_jp(key)
    { "blue" => "ブルー", "green" => "グリーン", "yellow" => "イエロー", "red" => "レッド" }[key]
  end

  def special_color_jp(key)
    { "gold" => "ゴールド", "platinum" => "プラチナ", "black" => "ブラック" }[key]
  end

  # 全て抽選済の色はリセット
  def reset_color(color)
    QuestCard.where(color: color).update_all(used: false)
  end
end
