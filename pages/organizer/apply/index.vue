<template>
  <v-card>
    <v-card-title class="justify-space-between">
      <span class="headline">主催者申請フォーム</span>
    </v-card-title>
    <v-card-text>
      <v-container>
        <v-form v-model="isFormValid">
          <v-col cols="12">
            <v-text-field v-model="form.name" label="氏名" required />
          </v-col>
          <v-col cols="12">
            <v-text-field v-model="form.email" label="メールアドレス" required />
          </v-col>
          <v-col cols="12">
            <v-text-field v-model="form.phone_number" label="電話番号" required />
          </v-col>
          <v-col cols="12">
            <div>利用したいサービス</div>
            <v-flex d-flex flex-wrap class="ml-4 mt-4">
              <v-checkbox
                v-for="item in $SERVICE_TYPE"
                :key="`service-${item.id}`"
                v-model="form.desired_service"
                :label="item.type"
                :value="item.type"
                class="ma-0"
              />
            </v-flex>
          </v-col>
        </v-form>
      </v-container>
    </v-card-text>
    <v-card-actions class="submit-button-area">
      <v-btn class="submit-button" color="primary" :disabled="!isFormValid" @click="submit">
        申請
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
export default {
  data () {
    return {
      form: {
        name: '',
        email: '',
        phone_number: '',
        desired_service: []
      },
      isFormValid: false
    }
  },
  methods: {
    submit () {
      this.$store
        .dispatch('api/apiRequest', {
          api: 'postOrganizerApply',
          params: {
            ...this.form
          }
        }).then(() => {
          this.$router.push('/')
        })
    }
  }
}
</script>

<style lang="scss" scoped>
@import '~/assets/scss/page.scss';
.container {
  width: 100%;
}
.page-header {
  @include default-page-header;
}
.page-header-sub {
  text-align: right;
}
.page-content {
  @include default-page-content;
  &-item {
    &-footer {
      justify-content: flex-start;
    }
    &-list {
      margin: 0px 12px;
    }
  }
  .tabs {
    margin: 24px 0px;
  }
}
.page-content-item-main.SP {
  flex-direction: column;
}
.page-content-item-list.SP {
  display: flex;
  justify-content: center;
}
.v-input {
  width: 100%;
}
.validation-message {
  display: flex;
  justify-content: end;
  width: 100%;
  padding-bottom: 16px;
  .text {
    color: red;
    font-size: 12px;
  }
}
.submit-button-area {
  display: flex;
  justify-content: center;
  .submit-button{
    margin-bottom: 16px;
  }
}
</style>
