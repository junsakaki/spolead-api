<template>
  <v-card>
    <v-card-text>
      <v-container>
        <v-col cols="12">
          <v-text-field v-model="form.name" label="サロン名" required />
        </v-col>
        <v-col cols="12">
          <v-text-field v-model="form.owner_name" label="サロンの主催者" required />
        </v-col>
        <v-col cols="12">
          <v-text-field v-model="form.caption" label="サロンの概要" required />
        </v-col>
        <v-col cols="12">
          <v-textarea
            v-model="form.content"
            autocomplete="サロン情報"
            label="サロン情報"
            dense
            required
          />
        </v-col>
        <v-col cols="12">
          <v-file-input
            label="サロンのイメージ画像"
            prepend-icon="mdi-camera"
            required
            @change="upload"
          />
        </v-col>
        <div class="subtitle-1 font-weight-bold">
          料金プラン
        </div>
        <v-card v-for="plan in form.plans" :key="plan.id" outlined tile class="mb-4">
          <v-col cols="12">
            <v-text-field v-model="plan.name" label="プランの名前" required />
          </v-col>
          <v-col cols="12">
            <v-text-field v-model="plan.caption" label="プランの説明" required />
          </v-col>
          <v-col cols="12">
            <v-text-field v-model="plan.price" label="月額料金" type="number" required />
          </v-col>
        </v-card>
        <v-btn color="primary" outlined block @click="addPlan">
          プランを追加
        </v-btn>
      </v-container>
    </v-card-text>
    <v-card-actions class="submit-button-area">
      <common-button class="submit-button" button-color="primary" @click="submit">
        申請
      </common-button>
    </v-card-actions>
  </v-card>
</template>

<script>
import CommonButton from '~/components/shared/atoms/CommonButton.vue'
export default {
  components: {
    CommonButton
  },
  data () {
    return {
      breadcrumbs: [
        ...this.$BREADCRUMBS,
        {
          text: 'オンラインサロンの登録申請',
          disabled: true
        }
      ],
      form: {
        name: '',
        owner_name: '',
        caption: '',
        content: '',
        image: '',
        plans: [
          { id: 1, name: '', caption: '', price: 0 }
        ]
      }
    }
  },
  methods: {
    submit () {
      console.log(this.form)
    },
    upload (file) {
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.form.image = fr.result
        })
      } else {
        this.form.image = ''
      }
    },
    addPlan () {
      this.form.plans.push({ id: this.form.plans.length + 1, name: '', caption: '', price: 0 })
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
