<template>
  <div>
    <!-- パンくずリスト -->
    <div class="breadcrumbs">
      <v-skeleton-loader type="text" class="skelton-text" width="100px" />
      <v-skeleton-loader type="text" class="skelton-text" width="100px" />
      <v-skeleton-loader type="text" class="skelton-text" width="100px" />
    </div>
    <div v-for="item in range(5)" :key="item.id" class="container">
      <v-sheet
        v-if="$vuetify.breakpoint.smAndDown"
        color="grey lighten-4"
        class="pa-1"
      >
        <div class="skelton-header SP">
          <v-skeleton-loader type="text" width="300px" class="skelton-header-item" />
          <div class="skelton-header-item SP">
            <v-skeleton-loader type="text" width="40px" class="skelton-header-item" />
            <v-skeleton-loader type="text" width="40px" class="skelton-header-item" />
          </div>
        </div>
        <div class="skelton-body SP">
          <div>
            <v-skeleton-loader type="image" width="224px" height="224px" />
          </div>
          <div>
            <v-skeleton-loader type="text" class="skelton-text" width="200px" />
            <v-skeleton-loader type="text" class="skelton-text" width="260px" />
            <v-skeleton-loader type="text" class="skelton-text" width="220px" />
          </div>
        </div>
      </v-sheet>
      <v-sheet
        v-else
        color="grey lighten-4"
        class="pa-1"
      >
        <div class="skelton-header">
          <v-skeleton-loader type="text" width="300px" class="skelton-header-item" />
          <v-skeleton-loader type="text" width="40px" class="skelton-header-item" />
          <v-skeleton-loader type="text" width="40px" class="skelton-header-item" />
        </div>
        <div class="skelton-body">
          <div>
            <v-skeleton-loader type="image" width="224px" height="224px" />
          </div>
          <div>
            <v-skeleton-loader type="text" class="skelton-text" width="500px" />
            <v-skeleton-loader type="text" class="skelton-text" width="560px" />
            <v-skeleton-loader type="text" class="skelton-text" width="520px" />
          </div>
        </div>
      </v-sheet>
    </div>
  </div>
</template>

<script>
import { range } from 'lodash'
export default {
  data () {
    return {
      range
    }
  }
}
</script>

<style lang="scss" scoped>
.container {
  margin: 12px 0;
}
.breadcrumbs {
  display: flex;
}
.skelton-header {
  display: flex;
  align-items: center;
  margin: 12px 0;
}
.skelton-header.SP {
  flex-direction: column;
  align-items: flex-start;
}
.skelton-header-item.SP {
  display: flex;
}
.skelton-body {
  display: flex;
  margin: 0 12px;
}
.skelton-body.SP {
  flex-direction: column;
  justify-content: center;
  align-items: center;
  margin: 0;
}
.skelton-text {
  margin: 12px;
}
.skelton-header-item {
  margin-left: 12px;
}
</style>
