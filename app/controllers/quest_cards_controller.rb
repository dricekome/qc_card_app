class QuestCardsController < ApplicationController
  def index
    @quest_cards = QuestCard.all
  end

  def show
    @quest_card = QuestCard.find(params[:id])
  end

  def new
    @quest_card = QuestCard.new
  end

  def create
    @quest_card = QuestCard.new(quest_card_params)
    if @quest_card.save
      redirect_to quest_cards_path, notice: 'カードを登録しました'
    else
      render :new
    end
  end

  def edit
    @quest_card = QuestCard.find(params[:id])
  end

  def update
    @quest_card = QuestCard.find(params[:id])
    if @quest_card.update(quest_card_params)
      redirect_to quest_cards_path, notice: 'カードを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @quest_card = QuestCard.find(params[:id])
    @quest_card.destroy
    redirect_to quest_cards_path, notice: 'カードを削除しました'
  end

  private

  def quest_card_params
    params.require(:quest_card).permit(:name, :color, :used)
  end
end
