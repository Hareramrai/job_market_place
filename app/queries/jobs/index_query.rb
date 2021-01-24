# frozen_string_literal: true

class Jobs::IndexQuery
  def initialize(relation = Job.all)
    @relation = relation
  end

  def call(search_params)
    search_by_title(search_params) if search_params[:title]
    search_by_language(search_params) if search_params[:language]

    @relation
  end

  private

    def search_by_title(search_params)
      @relation = @relation.where("title LIKE ?", "%#{search_params[:title]}%")
    end

    def search_by_language(search_params)
      @relation = @relation.tagged_with(search_params[:language])
    end
end
