namespace :invoice_subscription do
    desc "月々の主催者のサブスクリプション請求バッチ"
    task exec: :environment  do
        @month_range = (Date.today << 1).beginning_of_month..(Date.today << 1).end_of_month
        @month_range = (Date.today << 1).beginning_of_month..(Date.today).end_of_month

        @month = Time.new.strftime("%Y%m")
        @invoice_salons = UsersSalonsParticipation.where(created_at: @month_range)
        @invoice_salons.each{|invoice|
            begin
                @plan = Plan.find(invoice.plan_id)
                charge = Payjp::Charge.create(
                    :customer => invoice.customer_id,
                    :amount => invoice.amount,
                    :currency => 'jpy',
                    :tenant => @plan.payjp_tenant
                )
            rescue => e
                Rails.logger.info e
            end
        }
    end
end
