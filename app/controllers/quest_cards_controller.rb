class QuestCardsController < ApplicationController
  def index
    @quest_cards = QuestCard.all
  end

  def new
    @quest_card = QuestCard.new
  end

  def create
    names = params[:names]&.split(/\r?\n/)&.map(&:strip).reject(&:empty?)
    color = params[:color]

    if names.present?
      names.each do |name|
        QuestCard.create(name: name, color: color, used: false)
      end
      redirect_to quest_cards_path, notice: "#{names.size} 枚のカードを登録しました"
    else
      redirect_to new_quest_card_path, alert: "カード名を入力してください"
    end
  end

  def edit
    @quest_card = QuestCard.find(params[:id])
  end

  def update
    @quest_card = QuestCard.find(params[:id])
    if @quest_card.update(quest_card_params)
      redirect_to quest_cards_path, notice: "カードを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @quest_card = QuestCard.find(params[:id])
    @quest_card.destroy
    redirect_to quest_cards_path, notice: "カードを削除しました"
  end

  def edit_multiple
    @quest_cards = QuestCard.all.order(:id)
  end

  def update_multiple
    QuestCard.transaction do
      params[:quest_cards]&.each do |id, attributes|
        QuestCard.find(id).update!(used: attributes[:used] == "1")
      end
    end
    redirect_to edit_multiple_quest_cards_path, notice: "更新しました"
  rescue => e
    redirect_to edit_multiple_quest_cards_path, alert: "更新失敗：#{e.message}"
  end

  private

  def quest_card_params
    params.require(:quest_card).permit(:name, :color, :used)
  end
end
