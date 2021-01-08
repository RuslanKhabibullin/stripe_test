class CreatePaymentSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_sessions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false

      t.string :stripe_checkout_session_id
      t.string :stripe_payment_intent_id
      t.string :stripe_event_id

      t.string :state, null: false

      t.timestamps
    end

    add_index :payment_sessions, :stripe_checkout_session_id
  end
end
