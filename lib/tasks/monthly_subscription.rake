namespace :monthly_subscription do
    desc "月々の主催者のサブスクリプション集計バッチ"
    task organizer_totalizer: :environment  do
        @month_range = (Date.today << 1).beginning_of_month..(Date.today << 1).end_of_month
        @month = Time.new.strftime("%Y%m")
        organizers = User.where(role: "organizer").includes([:fund_owned, :salon_owned, :lesson_owned])
        organizers.each{|organizer|
        # クラウドファンディング：単発のみ
            funds = organizer.fund_owned
            funds.each{|fund|
                fund.reductions.each{|reduction|
                    reduction.purchases.where(created_at: @month_range).each{|purchase|
                        begin
                            unless OrganizerPool.exists?(organizer: organizer, participant: purchase.user, month: @month, subscribable_id: purchase.id, subscribable_type: purchase.class.name)
                                OrganizerPool.create({
                                    amount: purchase.total_amount,
                                    organizer: organizer,
                                    participant: purchase.user,
                                    month: @month,
                                    subscribable_id: purchase.id,
                                    subscribable_type: purchase.class.name
                                })
                            end
                        rescue => e
                            Rails.logger.info e.inspect
                            next
                        end
                    }
                }
            }
        # オンラインサロン：サブスクのみ
            salons = organizer.salon_owned
            salons.each{|salon|
                salon.plans.each{|plan|
                    plan.participations.each{|participation|
                        begin
                            unless OrganizerPool.exists?(organizer: organizer, participant: participation.user, month: @month, subscribable_id: participation.id, subscribable_type: participation.class.name)
                                OrganizerPool.create({
                                    amount: participation.total_amount,
                                    organizer: organizer,
                                    participant: participation.user,
                                    month:  @month,
                                    subscribable_id: participation.id,
                                    subscribable_type: participation.class.name
                                })
                            end
                        rescue => e
                            Rails.logger.info e.inspect
                            next
                        end
                    }
                }
            }
        # 指導者マッチング：両方
        # lesson_comment_payments.payment.present? サブスク : 単発
            lessons = organizer.lesson_owned
            lessons.each{|lesson|
                lesson.lessons_talk_rooms.each{|room|
                room.comments.active(@month_range).each{|comment|
                        begin
                            payment = comment.payment
                            unless OrganizerPool.exists?(organizer: organizer, participant: comment.user, month: @month, subscribable_id: comment.id, subscribable_type: comment.class.name)
                                OrganizerPool.create({
                                    amount: payment.amount,
                                    organizer: organizer,
                                    participant: comment.user,
                                    month:  @month,
                                    subscribable_id: comment.id,
                                    subscribable_type: comment.class.name
                                })
                            end
                        rescue => e
                            Rails.logger.info e.inspect
                            next
                        end
                    }
                }
            }
        }
    end

    desc "月々の参加者のサブスクリプション集計バッチ"
    task user_totalizer: :environment   do
        @month_range = (Date.today << 1).beginning_of_month..(Date.today << 1).end_of_month
        @month = Time.new.strftime("%Y%m")
        members = User.where(role: "member")
        members.each{|member|
        # クラウドファンディング：単発のみ
            purchases = member.users_reductions_purchases
            purchases.each{|purchase|
                begin
                    unless UserSubscription.exists?(user: member, month: @month, subscribable_id: purchase.id, subscribable_type: purchase.class.name)
                        UserSubscription.create({
                            amount: purchase.total_amount,
                            user: member,
                            month: @month,
                            subscribable_id: purchase.id,
                            subscribable_type: purchase.class.name
                        })
                    end
                rescue => e
                    Rails.logger.info e.inspect
                    next
                end
            }
        # # オンラインサロン：サブスクのみ
            participations = member.users_salons_participation
            participations.each{|participation|
                begin
                    unless UserSubscription.exists?(user: member, month: @month, subscribable_id: participation.id, subscribable_type: participation.class.name)
                        UserSubscription.create({
                            amount: participation.total_amount,
                            user: member,
                            month: @month,
                            subscribable_id: participation.id,
                            subscribable_type: participation.class.name
                        })
                    end
                rescue => e
                    Rails.logger.info e.inspect
                    next
                end
            }
        # # 指導者マッチング：両方
        # # lesson_comment_payments.payment.present? サブスク : 単発
            comments = member.lesson_comments
            comments.active(@month_range).each{|comment|
                begin
                    payment = comment.payment
                    unless UserSubscription.exists?(user: member, month: @month, subscribable_id: comment.id, subscribable_type: comment.class.name)
                        UserSubscription.create({
                            amount: payment.amount,
                            user: member,
                            month: @month,
                            subscribable_id: comment.id,
                            subscribable_type: comment.class.name
                        })
                    end
                rescue => e
                    Rails.logger.info e.inspect
                    next
                end
            }
        }
    end
end
