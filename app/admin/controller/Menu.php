<?php
// +----------------------------------------------------------------------
// | 后台菜单管理
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\model\Menu as MenuModel;
use app\admin\model\Tree;
use think\facade\App;
use think\facade\Db;
use think\facade\View;

class Menu extends Common
{
	
	protected $modelClass = null;
	
	public function initialize()
	{
		parent::initialize();
	}
	
	//后台菜单首页
	public function index()
	{
		if (request()->isAjax()) {
			$tree = new Tree();
			$tree->icon = array('', '', '');
			$tree->nbsp = '';
			$result = Db::name('auth_rule')->order('sort desc')->select()->toArray();
			$tree->init($result);
			
			$_list = $tree->getTreeList($tree->getTreeArray(0), 'title');
			
			$total = count($_list);
			$result = array("code" => 0, "count" => $total, "data" => $_list);
			// $tree = Db::name('auth_rule')->field('id,name,title,parent,type')->order('sort desc')->select()->toArray();
			// $tree = Db::name('auth_rule')->order('sort desc')->select()->toArray();
			// $total = count($tree);
			#数组重组
			//$tree = getTree_children($tree, 0);
			
			// return ajaxTable(0, '', $tree,$total);
			return json($result);
		}
		return View::fetch();
		
	}
	
	public function ajaxmenu()
	{
		$tree = Db::name('auth_rule')->order('sort desc')->select()->toArray();
		// halt(json_encode($tree,JSON_UNESCAPED_UNICODE));
		// echo json_encode($tree,JSON_UNESCAPED_UNICODE);
		return ajaxTable(0, '', json_encode($tree,JSON_UNESCAPED_UNICODE));
	}
	
	#新增菜单
	public function add()
	{
		if (request()->isAjax()) {
			$data = input();
			unset($data['s']);
			$data['name'] = $data['module'].'/'.$data['controller'].'/'.$data['action'];
			$data['name'] = strtolower($data['name']);
			$res = Db::name('auth_rule')->insert($data);
			if (empty($res)) {
				return ajaxTable(1);
			} else {
				return ajaxTable(0);
			}
		}
		$id = input('id', '');
		if ($id) {
			$first_menu = Db::name('auth_rule')->where(['type' => 0])->select();
			$data = Db::name('auth_rule')->where(['id' => $id, 'type' => 0])->find();
			view::assign('data', $data);
		} else {
			$first_menu = Db::name('auth_rule')->where(['type' => 0])->select();
		}
		view::assign("first_menu", $first_menu);
		#获取所有模块
		$module = App::initialize()->http->getName();
		$controller = $this->getController($module);
		
		view::assign(['module'=>$module,'controller'=>$controller]);
		
		return view::fetch();
	}
	
	#修改菜单
	public function edit()
	{
		if (request()->isAjax()) {
			$data = input();
			$id = $data['id'];
			unset($data['s']);
			$data['name'] = $data['module'].'/'.$data['controller'].'/'.$data['action'];
			$data['name'] = strtolower($data['name']);
			$res = Db::name('auth_rule')->where('id', $id)->update($data);
			if (empty($res)) {
				return ajaxTable(1);
			} else {
				return ajaxTable(0);
			}
		}
		$id = input('id', '');
		$first_menu = Db::name('auth_rule')->where(['type' => 0])->select();
		$data = Db::name('auth_rule')->where('id', $id)->find();
		// $data = Db::name('auth_rule')->find();
		$name = '修改菜单';
		$info = compact('first_menu', 'data', 'name');
		view::assign($info);
		#获取所有模块
		$module = App::initialize()->http->getName();
		$controller = $this->getController($module);
		$action = $this->getAction($data['controller']);
		view::assign(['module'=>$module,'controller'=>$controller,'action'=>$action]);
		return view::fetch();
	}
	
	#删除菜单
	public function del()
	{
		if (request()->isAjax()) {
			$id = input('id');
			$group = Db::name('auth_group')->select();
			foreach ($group as $list) {
				if (isset($list['rules'])) {
					if (!empty($list['rules'])) {
						$list_array = explode(",", $list['rules']);
						if (in_array($id, $list_array)) {
							return ajaxTable(1, '权限组 “' . $list['title'] . '” 还在使用该菜单，请先在权限组中取消选择，再删除');
						}
					}
				}
			}
			$result = Db::name('auth_rule')->where(["parent" => $id])->find();
			if ($result) {
				return ajaxTable(1, '含有子菜单，无法删除！');
			}
			$res = Db::name('auth_rule')->where(['id' => $id])->delete();
			if ($res) {
				return ajaxTable(0);
			} else {
				return ajaxTable(1);
			}
		}
	}
	
	public function getActionList()
	{
		$controller = input('controller');
		$list = $this->getAction($controller);
		
		return ajaxTable(0,'',$list);
	}
	
	// //添加后台菜单
	// public function add()
	// {
	//     if (request()->isPost()) {
	//         $data = request()->param();
	//         if (!isset($data['status'])) {
	//             $data['status'] = 0;
	//         } else {
	//             $data['status'] = 1;
	//         }
	//
	//         $result = $this->validate($data, 'Menu.add');
	//         if (true !== $result) {
	//             return $this->error($result);
	//         }
	//         if (MenuModel::create($data)) {
	//             $this->success("添加成功！", url("index"));
	//         } else {
	//             $this->error('添加失败！');
	//         }
	//     } else {
	//         $tree = new \util\Tree();
	//         $parentid = $this->request->param('parentid/d', '');
	//         $result = MenuModel::order(array('listorder', 'id' => 'DESC'))->select()->toArray();
	//         $array = array();
	//         foreach ($result as $r) {
	//             $r['selected'] = $r['id'] == $parentid ? 'selected' : '';
	//             $array[] = $r;
	//         }
	//         $tree->init($result);
	//         $select_categorys = $tree->getTree(0, '', $parentid);
	//         $this->assign("select_categorys", $select_categorys);
	//         return $this->fetch();
	//     }
	// }
	//
	// /**
	//  *编辑后台菜单
	//  */
	// public function edit()
	// {
	//     if ($this->request->isPost()) {
	//         $data = $this->request->param();
	//         if (!isset($data['status'])) {
	//             $data['status'] = 0;
	//         } else {
	//             $data['status'] = 1;
	//         }
	//         $result = $this->validate($data, 'Menu.edit');
	//         if (true !== $result) {
	//             return $this->error($result);
	//         }
	//         if (MenuModel::update($data)) {
	//             $this->success("编辑成功！", url("index"));
	//         } else {
	//             $this->error('编辑失败！');
	//         }
	//     } else {
	//         $tree = new \util\Tree();
	//         $id = $this->request->param('id/d', '');
	//         $rs = MenuModel::where(["id" => $id])->find();
	//         $result = MenuModel::order(array('listorder', 'id' => 'DESC'))->select()->toArray();
	//         $array = array();
	//         foreach ($result as $r) {
	//             $r['selected'] = $r['id'] == $rs['parentid'] ? 'selected' : '';
	//             $array[] = $r;
	//         }
	//         $tree->init($array);
	//         $select_categorys = $tree->getTree(0, '', $rs['parentid']);
	//         $this->assign("data", $rs);
	//         $this->assign("select_categorys", $select_categorys);
	//         return $this->fetch();
	//     }
	//
	// }
	
	
	/**
	 * 菜单删除
	 */
	// public function del()
	// {
	//     $id = $this->request->param('id/d');
	//     if (empty($id)) {
	//         $this->error('ID错误');
	//     }
	//     $result = MenuModel::where(["parentid" => $id])->find();
	//     if ($result) {
	//         $this->error("含有子菜单，无法删除！");
	//     }
	//     if (MenuModel::destroy($id) !== false) {
	//         $this->success("删除菜单成功！");
	//     } else {
	//         $this->error("删除失败！");
	//     }
	// }
	
}
