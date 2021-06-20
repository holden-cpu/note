参考：https://blog.csdn.net/qq_43284469/article/details/113924842

button：

- 使用element ui的相关组件时需要注意的是 所有组件都是【el-组件名称】开头
- 在element ui中组件的属性使用都是直接将==属性名=属性值==方式写在对应的组件标签上

radio：

- 在使用radio单选按钮是至少加入【v-model】和【label】两个属性
- 【label】指定显示的值，一般和标签内的值一致
- 【v-model】指定用来绑定的值
- 事件的使用也是和属性使用是一致都是直接写在对应的组件标签上
- 事件在使用时必须使用Vue中绑定时间方式进行使用如 @事件名=事件处理函数(绑在在vue组件中对应函数)

input：

- 使用组件的方法时需要在对应的组件中加入 `ref="组件别名"`
- 通过`this.$refs.组件别名.组件方法()`来调用

注意:

- 在elementui中所有组件 都存在 【属性、事件、方法】
- 属性：直接写在对应的组件标签上 使用方式:属性名=属性值方式

- 事件：直接使用vue绑定事件方式写在对应的组件标签上 使用方式:@事件名=vue中事件处理函数

- 方法： 1.  在对应组件标签上使用ref=组件别名；2. 通过使用this.$refs.组件别名.方法名()进行调用

```
.<template>
  <div>
    <el-table :data="tableData.filter(data => !search || data.name.toLowerCase().includes(search.toLowerCase()))" style="width: 100%">
      <el-table-column label="编号" width="180">
        <template slot-scope="scope">
          <span style="margin-left: 10px">{{ scope.row.id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="姓名" width="180">
        <template slot-scope="scope">
          <el-popover trigger="hover" placement="top">
            <p>姓名: {{ scope.row.name }}</p>
            <p>住址: {{ scope.row.address }}</p>
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium">{{ scope.row.name }}</el-tag>
            </div>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column label="生日" value-format="yyyy-MM-dd" prop="bir"> </el-table-column>
      <el-table-column label="性别" prop="sex"> </el-table-column>
      <el-table-column label="地址" prop="address"> </el-table-column>
      <el-table-column align="right">
        <template slot="header" slot-scope="scope">
          <el-input v-model="search" size="mini" placeholder="请输入姓名关键字" />
        </template>
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)"
            >编辑</el-button
          >
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete(scope.$index, scope.row)"
            >删除</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <el-button type='success' size='mini' style="margin-top: 10px">添加</el-button>
  </div>
</template>

<script>
export default {
  name: "List",
  data() {
    return {
      tableData: [
        {
          id: 1,
          name: "王小虎",
          bir: "2016-05-02",
          address: "上海市普陀区金沙江路 1518 弄",
          sex: "男",
        },
        {
          id: "2",
          name: "郑小昌",
          bir: "2026-05-02",
          address: "温州市普陀区金沙江路 1518 弄",
          sex: "男",
        },
      ],
      search: ''
    };
  },
  methods: {
    handleEdit(index, row) {
      console.log(index, row);
    },
    handleDelete(index, row) {
      console.log(index, row);
    },
  },
};
</script>

<style></style>

```

