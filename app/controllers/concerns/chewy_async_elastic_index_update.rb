module ChewyAsyncElasticIndexUpdate
  extend ActiveSupport::Concern

  included do
    around_action :wrap_in_chewy_async_elastic_index_update
  end

  private

  def wrap_in_chewy_async_elastic_index_update(&block)
    if Rails.env.test?
      block.call
    else
      Chewy.strategy(:sidekiq) do
        block.call
      end
    end
  end
end
